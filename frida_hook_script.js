// Helper function to patch memory at an offset
function patchMemory(offset, bytes) {
    var baseAddr = Module.findBaseAddress("UnityFramework"); // Thay UnityFramework bằng đúng binary của app
    if (baseAddr === null) {
        console.log("Unable to find base address.");
        return;
    }

    var patchAddr = baseAddr.add(offset); // Tính địa chỉ cần patch
    Memory.protect(patchAddr, bytes.length, 'rwx');  // Cho phép ghi vào bộ nhớ
    patchAddr.writeByteArray(bytes); // Ghi bytes vào địa chỉ
    console.log("Patched address: " + patchAddr);
}

// Hàm để nhận yêu cầu patch từ ứng dụng iOS
rpc.exports = {
    patchfunction: function (functionName) {
        console.log("Received request to patch function: " + functionName);

        if (functionName === "hack_map") {
            patchMemory(0x5331A08, [0x36, 0x00, 0x80, 0xD2]); // Hack Map
        } else if (functionName === "cam_xa") {
            patchMemory(0x6132194, [0x00, 0x90, 0x2F, 0x1E]); // Cam Xa
        } else if (functionName === "show_rank") {
            patchMemory(0x5EEC550, [0x1F, 0x20, 0x03, 0xD5]); // Hiện Rank
        } else if (functionName === "show_ulti") {
            patchMemory(0x5E17B98, [0x1F, 0x20, 0x03, 0xD5]); // Hiện Ulti
        } else {
            console.log("Unknown function: " + functionName);
        }
    }
};

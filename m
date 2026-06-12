Return-Path: <linux-erofs+bounces-3573-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1CKWAjh+K2o7+gMAu9opvQ
	(envelope-from <linux-erofs+bounces-3573-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jun 2026 05:34:16 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9BD676706
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jun 2026 05:34:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=AUK31Ct1;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3573-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3573-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc4r248M2z3brB;
	Fri, 12 Jun 2026 13:34:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781235250;
	cv=none; b=dJlu8bQqLpyXf4TzcipuwKP4voKREcbd+ttsYHmgvkW6Ic5ARLgX8aRo0NXkgKmPJG/nkT9Nr7kZ+ehVZTEWf/N92gpzoHlk94T/y+k5DOWQQAS2rnGlM65Qr4AaeOWGD7niZHyMZ4TudyNCs/ZoL8zfzzxz02sTrbqwLbT1cEFckrxny0HtA+vAmN+kAGy+K/0TSOQDbzZvR5C3EaWC9kb8DY4itAaYbX3gRt+PnDhLS1GKwSNZYt3S+x4obF9E9FXyqkjqhp6sQHlE9WwQWHuymaEiqKQuS0KFc1eCvGGXSsYzXSc13MkJRJq5GsX8PKtVfHNY0mvE8WDITTUcKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781235250; c=relaxed/relaxed;
	bh=736++BgMd3sNdjNlMHgazLRHuas57sRQpTp2IuK3eXU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m/utZ+FALmYFz6AlpT4NM5Xki8cSMLeToIR+mcwtdbiglmkipGvSrQqecoH6XltExrDzFm4NWpsr/I4Iww/QDGN3jC16WgeF2gE6vTUGVUQLP5cq2QfEHGEy58eBaprHqFtGJM6vLWo5bFnQa+D/QYBvp6VaFqr9BnvCE90shLURiYpwYUH9KqkbhkSH6YHfKuJ+kErRIOChU6c8I87/yuXpuaTuWVgqulnhlhwB9gsPE64e+iiMef5m16oowoNV/aK6G8OeRVEM8dHCRGV2n0jlFZsGEMWUS508hg399+zufGlAuHtpWUENM4PZCUavgnSy4BJGUwdz7OXmm0u7Fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=AUK31Ct1; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc4qz2DsMz3bpt
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Jun 2026 13:34:04 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=736++BgMd3sNdjNlMHgazLRHuas57sRQpTp2IuK3eXU=;
	b=AUK31Ct11UIE0BDrmPJfiE2ZuvYkZnnE/PbOhfURAWjPPx3bwDHRMgT+UOcntoQavHcIZXqsk
	Rh0/gsu/RgjK3d2OnsAks66C8yYCnNYOIHbCLAtIMV5aiOernGEQyr6s25PWlAp8o0sG67jc1Q2
	z9PlAvObFJhgBNxrYDlZMks=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gc4fZ2QDYz1prN3;
	Fri, 12 Jun 2026 11:25:58 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 360FC40561;
	Fri, 12 Jun 2026 11:33:56 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 12 Jun
 2026 11:33:55 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>, <hsiangkao@linux.alibaba.com>
CC: <linux-kernel@vger.kernel.org>, <yekelu1@huawei.com>,
	<jingrui@huawei.com>, <zhukeqian1@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH] erofs: prevent buffered read bio merges across device chunks
Date: Fri, 12 Jun 2026 11:32:44 +0800
Message-ID: <20260612033244.993507-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3573-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	HAS_XOIP(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[run-loop-read.sh:url,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D9BD676706

EROFS chunked files may place adjacent logical chunks on different
devices. The physical block numbers are per-device, so two neighboring
chunks can still look sector-contiguous to the generic iomap buffered
read code.

For example:

        logical file offset
        0          8K         16K        24K
        +----------+----------+----------+
        | chunk 0  | chunk 1  | chunk 2  |
        +----------+----------+----------+
             |          |          |
             v          v          v
          dev 1      dev 3      dev 3
          sector 8   sector 24  sector 40

The transition from chunk 0 to chunk 1 crosses a device boundary, but
iomap can still treat sector-contiguous bios as mergeable without
checking whether they belong to the same device.

The pending bio, however, is still bound to the previous block device:

        bio->bi_bdev = dev 1

        file 0..8K   -> dev 1, sector 8
        file 8..16K  -> dev 3, sector 24
                         (must not be added here)

If the second range is added to the same bio, it will be submitted to
dev 1 and read from the wrong backing device, which is easy to trigger
with readahead.

This only affects paths using erofs_aops, where buffered reads go
through iomap bio helpers.

Fix by install EROFS-specific iomap read ops and split the pending
buffered read bio whenever the next mapped range belongs to a different
bdev. After the split, fall back to the generic iomap bio read helper
for the normal sector-based merge checks.

Reported-by: Kelu Ye <yekelu1@huawei.com>
Assisted-by: Codex:GPT-5.5
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
Reproducer:

This reproducer builds a tiny blob-index EROFS image and three raw blob
devices.  The file /mem.bin has three 4K chunks:

        chunk 0 -> device1.bin, offset 0K  -> 'A'
        chunk 1 -> device2.bin, offset 4K  -> 'B'
        chunk 2 -> device3.bin, offset 8K  -> 'C'

The physical sector numbers are contiguous, but the chunks are on
different block devices.  On an affected kernel, loop-device readahead
may merge the reads into a single bio on device1 and return A/A/A.
With this patch applied, the read returns A/B/C.

Current userspace tools do not provide a simple way to generate this
exact trigger image directly. The reproducer therefore lets mkfs.erofs
create a valid tiny chunked metadata image first, then manually patches
the chunk index and extra-device table to construct the wanted mapping.

Save the following as build-small-repro.sh:

```sh
#!/bin/sh
set -eu

BASE=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
CHUNK_SIZE=4096
FILE_SIZE=$((CHUNK_SIZE * 3))

rm -rf "$BASE/src"
rm -f "$BASE"/*.erofs "$BASE"/*.bin
mkdir -p "$BASE/src"

# The final image uses three raw blob devices, not EROFS layer images:
#
#       device1.bin:
#         0K            4K            8K           12K
#         +-------------+-------------+-------------+
#         |      A      |      A      |      A      |
#         +-------------+-------------+-------------+
#
#       device2.bin:
#         0K            4K            8K           12K
#         +-------------+-------------+-------------+
#         |    padding  |      B      |      B      |
#         +-------------+-------------+-------------+
#
#       device3.bin:
#         0K            4K            8K           12K
#         +-------------+-------------+-------------+
#         |    padding  |    padding  |      C      |
#         +-------------+-------------+-------------+
#
# Patch /mem.bin chunk indexes to point to sector-contiguous offsets
# across different devices:
#
#       logical chunk:      0       1       2
#                        +------+------+------+
#       expected data:   |  A   |  B   |  C   |
#                        +------+------+------+
#       target device:     dev1   dev2   dev3
#       target offset:       0K     4K     8K
#       target startblk:     0      1      2
#
# An affected kernel may merge those reads into one bio on dev1 because
# the sector numbers are contiguous, producing A, A, A instead.

perl -e 'print "A" x 12288' > "$BASE/device1.bin"
perl -e 'print "P" x 4096; print "B" x 8192' > "$BASE/device2.bin"
perl -e 'print "P" x 8192; print "C" x 4096' > "$BASE/device3.bin"

# Build a tiny chunked EROFS metadata image first.  The temporary blob is
# only a source for mkfs.erofs; the final image points at device*.bin.
perl -e '
	print "X" x 4096;
	print "Y" x 4096;
	print "Z" x 4096;
' > "$BASE/src/mem.bin"

mkfs.erofs -Enosbcrc --chunksize="$CHUNK_SIZE" \
	--blobdev="$BASE/unimportant.blob" \
	"$BASE/merge.raw.erofs" "$BASE/src"

# Binary hack for this exact tiny image produced above:
#
#   /mem.bin NID          = 43
#   inode offset          = 43 * 32 = 1376
#   chunk table offset    = 1408
#   old device table      = super.devt_slotoff * 128 = 1152
#   new device table      = 24 * 128 = 3072
#
# Chunk index entry layout:
#
#   u16 startblk_hi, u16 device_id, u32 startblk_lo
#
# Write the wanted entries:
#
#   chunk0 -> device 1, startblk 0  (device1.bin + 0K)
#   chunk1 -> device 2, startblk 1  (device2.bin + 4K)
#   chunk2 -> device 3, startblk 2  (device3.bin + 8K)
python3 - "$BASE" <<'PY'
import struct
import sys
from pathlib import Path

base = Path(sys.argv[1])
data = bytearray((base / "merge.raw.erofs").read_bytes())

SUPER = 1024
EXTRA_DEVICES = SUPER + 86
DEVT_SLOTOFF = SUPER + 88
DEVICE_SLOT_SIZE = 128
DEVICE_BLOCKS = 3
NEW_DEVT_SLOTOFF = 24
CHUNK_TABLE = 1408

struct.pack_into("<H", data, EXTRA_DEVICES, 3)
struct.pack_into("<H", data, DEVT_SLOTOFF, NEW_DEVT_SLOTOFF)

for i, (device_id, startblk) in enumerate([(1, 0), (2, 1), (3, 2)]):
    struct.pack_into("<HHI", data, CHUNK_TABLE + i * 8, 0,
                     device_id, startblk)

slot_start = NEW_DEVT_SLOTOFF * DEVICE_SLOT_SIZE
for i in range(3):
    data[slot_start + i * DEVICE_SLOT_SIZE:
         slot_start + (i + 1) * DEVICE_SLOT_SIZE] = b"\0" * DEVICE_SLOT_SIZE
    struct.pack_into("<I", data, slot_start + i * DEVICE_SLOT_SIZE + 64,
                     DEVICE_BLOCKS)

(base / "merged.erofs").write_bytes(data)
PY

rm -f "$BASE/unimportant.blob"
printf 'Generated images under %s\n' "$BASE"
```

Save the following as run-loop-read.sh in the same directory:

```sh
#!/bin/sh
set -eu

./build-small-repro.sh

MNT=/tmp/erofs-mnt
sudo mkdir -p "$MNT"

META=$(sudo losetup -f --show merged.erofs)
D1=$(sudo losetup -f --show device1.bin)
D2=$(sudo losetup -f --show device2.bin)
D3=$(sudo losetup -f --show device3.bin)

cleanup() {
	sudo umount "$MNT" 2>/dev/null || true
	sudo losetup -d "$META" "$D1" "$D2" "$D3" 2>/dev/null || true
}
trap cleanup EXIT

echo "META=$META"
echo "D1=$D1"
echo "D2=$D2"
echo "D3=$D3"

sudo blockdev --setra 5120 "$META" "$D1" "$D2" "$D3"
sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'

sudo mount -t erofs \
	-o device="$D1",device="$D2",device="$D3" \
	"$META" "$MNT"

dd if="$MNT/mem.bin" bs=12288 count=1 iflag=fullblock status=none |
	hexdump -C
```

Expected output with the fix:

```text
        00000000  41 41 41 41 41 41 41 41  ...
        *
        00001000  42 42 42 42 42 42 42 42  ...
        *
        00002000  43 43 43 43 43 43 43 43  ...
```

An affected kernel may return 'A' at offsets 0x1000 and 0x2000 as well.

 fs/erofs/data.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 44da21c9d777..5851425eec22 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -376,6 +376,37 @@ static const struct iomap_ops erofs_iomap_ops = {
 	.iomap_end = erofs_iomap_end,
 };
 
+static void erofs_iomap_submit_read(const struct iomap_iter *iter,
+				    struct iomap_read_folio_ctx *ctx)
+{
+	iomap_bio_read_ops.submit_read(iter, ctx);
+}
+
+static int erofs_iomap_read_folio_range(const struct iomap_iter *iter,
+					struct iomap_read_folio_ctx *ctx,
+					size_t len)
+{
+	struct bio *bio = ctx->read_ctx;
+
+	/*
+	 * EROFS multi-device chunks may map adjacent file ranges to different
+	 * block devices whose sector numbers still look contiguous.  Split the
+	 * pending bio at device boundaries so I/O for different devices cannot be
+	 * mixed into the same bio by the generic sector-based iomap merge logic.
+	 */
+	if (bio && bio->bi_bdev != iter->iomap.bdev) {
+		erofs_iomap_submit_read(iter, ctx);
+		ctx->read_ctx = NULL;
+	}
+
+	return iomap_bio_read_folio_range(iter, ctx, len);
+}
+
+static const struct iomap_read_ops erofs_iomap_read_ops = {
+	.read_folio_range	= erofs_iomap_read_folio_range,
+	.submit_read		= erofs_iomap_submit_read,
+};
+
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 start, u64 len)
 {
@@ -395,7 +426,7 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
 	struct iomap_read_folio_ctx read_ctx = {
-		.ops		= &iomap_bio_read_ops,
+		.ops		= &erofs_iomap_read_ops,
 		.cur_folio	= folio,
 	};
 	bool need_iput;
@@ -413,7 +444,7 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
 static void erofs_readahead(struct readahead_control *rac)
 {
 	struct iomap_read_folio_ctx read_ctx = {
-		.ops		= &iomap_bio_read_ops,
+		.ops		= &erofs_iomap_read_ops,
 		.rac		= rac,
 	};
 	bool need_iput;
-- 
2.47.3



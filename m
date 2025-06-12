Return-Path: <linux-erofs+bounces-394-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CE790AD690C
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jun 2025 09:31:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHvN93Q7Qz2xlL;
	Thu, 12 Jun 2025 17:31:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749713481;
	cv=none; b=j8+Q0qvraVaI5vCcO86Sy8Q91s2zDdWTAUeV02gPAbel4l4g6GE1UJp383xj9hhxvCk7bmg0CJklghrDP/T9AbC9mgMKo6agdEvW8hLhEY92If8t5e2wM7lWWTERuCoVPj991yw4r+B/bInKmqxd1PGNFnou7TkZEDrAhTX3MNs5gW63JNBvkglsJKR5pe3dX0NHkTFDMGQMHM50PTONet3YEXau7IN9autp9Ks2IZc6K3juuES+9QEUxok68ABUnKbvOPoleNP1Y/3CqJRvTkzGpq95lrnZBrkts+MXc9Hr8f545GLirAulBuwbbYtYRdjnAXLY/dOY9emOiuEdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749713481; c=relaxed/relaxed;
	bh=4+aaqx9BRIXNzAujL6lk8XN2/DQCVdod4hF8PZuWtn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkSFcqeg+UTG59RQ0fIszWB1CtkR0BzvfB/fjJ6jlfA+E8ZtRDAAFxeaQ/2ztslxvr7KWGREJLSOuj5oID9sK4IsaM/wTzwF++f/7lK6RcJOjJ/u/btHiLGgdEK7Qio+qb4xQiz4SxCLqnyanQvvOweTmyXSqEEDNaDR+WqCF6IMFBune18voIV5yX9ulnyiJN/JYkHaDhLZNsnzGDgKsWuF3IeGN6oaDAEk0hHIZdtLZZHv2Aze9WBGpykUCvHXDj50L93i8Dckp0wt3dMzxRL3tpti0O+/hP4+64jS69G/o0V1A8P2QPM1oc9codLSwECafpdheg9epJzx4GspBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Aswq4cdE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Aswq4cdE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHvN56rrqz2xPL
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Jun 2025 17:31:16 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749713473; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4+aaqx9BRIXNzAujL6lk8XN2/DQCVdod4hF8PZuWtn0=;
	b=Aswq4cdEoQbzM/1J9r4hyjbURqv81A7Fhi3nJqngdh2KOcCmxQEG0rLE1QqZoiR+vqnDjtTucVZYQiP++gp/9HpSSfGG7g4pNCl8md0Qtt60mVdZtHx0fEy0mUjKHlI4foUIqCprHdcjhZU5c/nn7u14ds464fqxbEk36lxf9nk=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wdg-kqY_1749713470 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Jun 2025 15:31:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Fabiano Fidencio <fabiano@fidencio.org>,
	Xin Yin <yinxin.x@bytedance.com>,
	Jia Zhu <zhujia.zj@bytedance.com>,
	Fupan Li <fupan.lfp@antgroup.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs-utils: mkfs: generate VMDK format for flattened block devices
Date: Thu, 12 Jun 2025 15:31:03 +0800
Message-ID: <20250612073103.2538455-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250612073103.2538455-1-hsiangkao@linux.alibaba.com>
References: <20250612073103.2538455-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

EROFS has supported "native sub-filesystem merging" as a single block
device since kernel commit 8b465fecc35a ("erofs: support flattened block
device for multi-blob images").  It allows sub-filesystems (e.g., EROFS
container layers) to be merged into one filesystem and mounted in
a single shot, which is particularly useful for layered container images
in VM-based secure containers where file-backed mounts are unusable.

Additionally, it can also be used to pass through external data (such as
a tar file) w/o attaching an extra block device to the guest.

Intuitively, there are two approaches to generate a single merged block
device for virtualization scenarios:
 - Concatenate fsmeta + sub-image files, for example, to merge
   `[tar index][tar data]`:

    $ mkfs.erofs --tar=i foo.erofs foo.tar
    $ cat foo.tar >> foo.erofs

   This approach is inefficient unless the host filesystem supports
   reflinks: but a major player, EXT4, does not.

 - Use the virtual block device approach on the host (e.g., NBD, TCMU,
   UBLK) or vhost-user-blk to generate merged devices in the guest.
   However, this requires an additional daemon to stay active, which can
   be inconvenient.

Furthermore, I wondered whether any virtual disk format supports this
functionality.  After doing some research on popular formats, I found
that only VMDK [1] and VHD [2] natively support merging split files.
QEMU appears to have supported VMDK split files [3] since very early
versions.

Add a `--vmdk-desc` option to generate valid `twoGbMaxExtentFlat` VMDK
descriptor files and use the following QEMU option to attach:
  -drive file=foo.vmdk,format=vmdk,if=virtio

Hopefully, Cloud Hypervisor and other microVMs could support VMDK or
concatenating raw files as a single block device in the future.

[1] https://www.vmware.com/app/vmdk/?src=vmdk
[2] See `Splitting Hard Disk Images` in the VHD Format Specification
    https://www.microsoft.com/en-us/download/details.aspx?id=23850
[3] https://github.com/qemu/qemu/blob/master/block/vmdk.c

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  3 ++
 lib/Makefile.am          |  3 +-
 lib/vmdk.c               | 74 ++++++++++++++++++++++++++++++++++++++++
 man/mkfs.erofs.1         |  4 +++
 mkfs/main.c              | 15 ++++++++
 5 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 lib/vmdk.c

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 8916be1..d3debc6 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -511,6 +511,9 @@ static inline int erofs_blk_read(struct erofs_sb_info *sbi, int device_id,
 			      erofs_pos(sbi, nblocks));
 }
 
+/* vmdk.c */
+int erofs_dump_vmdk_desc(FILE *f, struct erofs_sb_info *sbi);
+
 #ifdef EUCLEAN
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 #else
diff --git a/lib/Makefile.am b/lib/Makefile.am
index bdc74ad..688403b 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -35,7 +35,8 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
 		      fragments.c dedupe.c uuid_unparse.c uuid.c tar.c \
-		      block_list.c rebuild.c diskbuf.c bitops.c dedupe_ext.c
+		      block_list.c rebuild.c diskbuf.c bitops.c dedupe_ext.c \
+		      vmdk.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
 if ENABLE_LZ4
diff --git a/lib/vmdk.c b/lib/vmdk.c
new file mode 100644
index 0000000..06d4a49
--- /dev/null
+++ b/lib/vmdk.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+#include "erofs/internal.h"
+
+static int erofs_vmdk_desc_add_extent(FILE *f, u64 sectors,
+				      const char *filename, u64 offset)
+{
+	static const char extent_line_fmt[] =
+		"RW %" PRIu64 " FLAT \"%s\" %" PRIu64 "\n";
+
+	while (sectors) {
+		u64 count = min_t(u64, sectors, 0x80000000 >> 9);
+		int ret;
+
+		ret = fprintf(f, extent_line_fmt, count, filename, offset);
+		if (ret < 0)
+			return -errno;
+		offset += count;
+		sectors -= count;
+	}
+	return 0;
+}
+
+int erofs_dump_vmdk_desc(FILE *f, struct erofs_sb_info *sbi)
+{
+	static const char desc_template_1[] =
+		"# Disk DescriptorFile\n"
+		"version=1\n"
+		"CID=%" PRIx32 "\n"
+		"parentCID=%" PRIx32 "\n"
+		"createType=\"%s\"\n"
+		"\n"
+		"# Extent description\n";
+	static const char desc_template_2[] =
+		"\n"
+		"# The Disk Data Base\n"
+		"#DDB\n"
+		"\n"
+		"ddb.virtualHWVersion = \"%s\"\n"
+		"ddb.geometry.cylinders = \"%" PRIu64 "\"\n"
+		"ddb.geometry.heads = \"%" PRIu32 "\"\n"
+		"ddb.geometry.sectors = \"63\"\n"
+		"ddb.adapterType = \"%s\"\n";
+	static const char subformat[] = "twoGbMaxExtentFlat";
+	static const char adapter_type[] = "ide";
+	u32 cid = ((u32 *)sbi->uuid)[0] ^ ((u32 *)sbi->uuid)[1] ^
+		((u32 *)sbi->uuid)[2] ^ ((u32 *)sbi->uuid)[3];
+	u32 parent_cid = 0xffffffff;
+	u32 number_heads = 16;
+	char *hw_version = "4";
+	u64 total_sectors, sectors;
+	int ret, i;
+
+	fprintf(f, desc_template_1, cid, parent_cid, subformat);
+	sectors = sbi->primarydevice_blocks << (sbi->blkszbits - 9);
+	ret = erofs_vmdk_desc_add_extent(f, sectors, (char *)sbi->devname, 0);
+	if (ret)
+		return ret;
+	total_sectors = sectors;
+	for (i = 0; i < sbi->extra_devices; ++i) {
+		const char *name = sbi->devs[i].src_path ?:
+				(const char *)sbi->devs[i].tag;
+
+		sectors = sbi->devs[i].blocks << (sbi->blkszbits - 9);
+		ret = erofs_vmdk_desc_add_extent(f, sectors, name, 0);
+		if (ret)
+			return ret;
+		total_sectors += sectors;
+	}
+
+	fprintf(f, desc_template_2, hw_version,
+		(u64)DIV_ROUND_UP(total_sectors, 63ULL * number_heads),
+		number_heads, adapter_type);
+	return 0;
+}
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 48202b6..63f7a2f 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -270,6 +270,10 @@ together.
 Filter tarball streams through xz, lzma, or lzip. Optionally, raw streams can
 be dumped together.
 .TP
+.BI "\-\-vmdk-desc=" FILE
+Generate a VMDK descriptor file to merge sub-filesystems, which can be used
+for tar index or rebuild mode.
+.TP
 .BI "\-\-xattr-prefix=" PREFIX
 Specify a customized extended attribute namespace prefix for space saving,
 e.g. "trusted.overlay.".  You may give multiple
diff --git a/mkfs/main.c b/mkfs/main.c
index ef83f2e..14ea6ff 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -90,6 +90,7 @@ static struct option long_options[] = {
 	{"async-queue-limit", required_argument, NULL, 530},
 #endif
 	{"fsalignblks", required_argument, NULL, 531},
+	{"vmdk-desc", required_argument, NULL, 532},
 	{0, 0, 0, 0},
 };
 
@@ -210,6 +211,7 @@ static void usage(int argc, char **argv)
 		" --unxz[=X]            try to filter the tarball stream through xz/lzma/lzip\n"
 		"                       (and optionally dump the raw stream to X together)\n"
 #endif
+		" --vmdk-desc=X         generate a VMDK descriptor file to merge sub-filesystems\n"
 #ifdef EROFS_MT_ENABLED
 		" --workers=#           set the number of worker threads to # (default: %u)\n"
 #endif
@@ -254,6 +256,7 @@ static bool valid_fixeduuid;
 static unsigned int dsunit;
 static unsigned int fsalignblks = 1;
 static int tarerofs_decoder;
+static FILE *vmdk_dcf;
 
 static int erofs_mkfs_feat_set_legacy_compress(bool en, const char *val,
 					       unsigned int vallen)
@@ -988,6 +991,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return -EINVAL;
 			}
 			break;
+		case 532:
+			vmdk_dcf = fopen(optarg, "wb");
+			if (!vmdk_dcf) {
+				erofs_err("failed to open vmdk desc `%s`", optarg);
+				return -EINVAL;
+			}
+			break;
 		case 'V':
 			version();
 			exit(0);
@@ -1548,6 +1558,11 @@ int main(int argc, char **argv)
 		if (!err)
 			erofs_info("superblock checksum 0x%08x written", crc);
 	}
+
+	if (!err && vmdk_dcf) {
+		err = erofs_dump_vmdk_desc(vmdk_dcf, &g_sbi);
+		fclose(vmdk_dcf);
+	}
 exit:
 	if (root)
 		erofs_iput(root);
-- 
2.43.5



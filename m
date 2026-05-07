Return-Path: <linux-erofs+bounces-3381-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LQYG6ce/GkCLwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3381-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 07 May 2026 07:09:59 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75134E3025
	for <lists+linux-erofs@lfdr.de>; Thu, 07 May 2026 07:09:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gB0g45lMYz2yrD;
	Thu, 07 May 2026 15:09:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778130592;
	cv=none; b=crxYzkE0nAgpZGP7wS64mrdHLymB3Cx5rhA2QRf5nUzJWAFLRKvXOAmzDOhP4KjSa0y/O0lrdYvrAqsWSuDBBjzR+Wa8VrIXAGu4BmNTOqIuQ5NJ+7K4ApKm97xGsRXUqNw5PVIuo7lPvw04NZEvT7ICrXwl9ewhLe9umbAhku0olBeXbf7DemdsnVa2um4Af9tSr+pX5ObLsip6xst6zvjgKjw7LS27CwD7U++KDjWxkkhx8gVHsQiqZOvF4D7bEy98TpY6gfcl3ThlxYPHhN4KHdusITVwBU5TBkpIILP4BqS8hoJu7fxtww3EdUItH2LHcccBQtDh6y1w/6BSjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778130592; c=relaxed/relaxed;
	bh=DupCD2RK6VPvgYGdTJ7ZaGN/rPRSe227gonAU/MffN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Du4yQu4jBZp4/JESpLRCwyEuz47aOysS24mAQk/OF940SDOYPrlK56COBgPJq8URHC+J1KAbk6YDNDTiOY+ziiVBvcnGtzXFI6A4+Mp7ZXgs/wh1JRB2oBxEA/PqkjBeXw9d856JPnaTMqohouUEAIMqSqofictQxz0nShYZd4U69iqYwuEyKNId6dPn8bbMMZwfHFCFyZ8zeHBuhU9F2iXbuKqY3AUey/xOO8fcaEbrLQ+546gDCXwY2c+8bYnEN7bBXs8fXZIGq0q8OfX/HGC4Y2sN7IECwe8yGT3nqDWW2z4to5CCCVCX7t1bO5K1UMxRD5n5GstI3R5sy4YbDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=yanmengdie24@mails.ucas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=mails.ucas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mails.ucas.ac.cn (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=yanmengdie24@mails.ucas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gB0g22C5cz2xZK
	for <linux-erofs@lists.ozlabs.org>; Thu, 07 May 2026 15:09:48 +1000 (AEST)
Received: from localhost.localdomain (unknown [14.22.11.162])
	by APP-03 (Coremail) with SMTP id rQCowAD3AsqSHvxpMmhLEA--.42925S2;
	Thu, 07 May 2026 13:09:40 +0800 (CST)
From: Mengdie Yan <yanmengdie24@mails.ucas.ac.cn>
To: linux-erofs@lists.ozlabs.org
Cc: hudsonzhu@tencent.com,
	xiang@kernel.org,
	chao@kernel.org,
	jefflexu@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	Mengdie Yan <yanmengdie24@mails.ucas.ac.cn>
Subject: [PATCH] erofs-utils: mkfs: support hot-file-list for tar and OCI full sources
Date: Thu,  7 May 2026 13:09:38 +0800
Message-ID: <20260507050938.2388894-1-yanmengdie24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.43.7
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
X-CM-TRANSID:rQCowAD3AsqSHvxpMmhLEA--.42925S2
X-Coremail-Antispam: 1UD129KBjvJXoW3KF1UGrWxWrW8ZFWkCF4kZwb_yoWkWrW5pr
	4akr4rX3y8KFy7uw4IqF1a9r1ag3Wktr47KaySgrs5JFn5JrsrtF4kArWjqay5Wrs5XrWY
	qr429ay3ur1DJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbsYFJUUUUU==
X-Originating-IP: [14.22.11.162]
X-CM-SenderInfo: 51dqzv5qjgxvysu6ztxlovh3xfdvhtffof0/
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: B75134E3025
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.00 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3381-lists,linux-erofs=lfdr.de];
	DMARC_NA(0.00)[ucas.ac.cn];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_NEQ_ENVFROM(0.00)[yanmengdie24@mails.ucas.ac.cn,linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_XOIP(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mails.ucas.ac.cn:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Action: no action

Extract hot-file marking helpers so non-local import paths can reuse the
existing ranking logic. This extends --hot-file-list support from local
directories to tar full mode and OCI full mode while keeping index, rvsp
and zerofill modes rejected.

For tar/OCI imports, hot ranks now follow regular entries, hardlink
aliases and auto-created parent directories so hot files remain in the
front layout region even when the source stream does not come from a
local rootfs walk.

Add regression tests for tar full mode, hardlink aliases, unsupported
non-full tar modes, and compressed tar full builds so hot layout remains
effective with zstd compression as well.
---
 include/erofs/inode.h   |  2 +
 lib/inode.c             | 48 ++++++++++++++++--------
 lib/rebuild.c           |  1 +
 lib/tar.c               |  2 +
 mkfs/main.c             | 26 +++++++++++--
 tests/hotfile-layout.sh | 82 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 142 insertions(+), 19 deletions(-)

diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index bf089e8..9aef660 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -43,6 +43,8 @@ int erofs_allocate_inode_bh_data(struct erofs_inode *inode, erofs_blk_t nblocks,
 bool erofs_dentry_is_wht(struct erofs_sb_info *sbi, struct erofs_dentry *d);
 int __erofs_fill_inode(struct erofs_importer *im, struct erofs_inode *inode,
 		       struct stat *st, const char *path);
+void erofs_inode_set_hot(struct erofs_inode *inode, const char *path);
+void erofs_inode_update_hot_file(struct erofs_inode *inode, const char *path);
 struct erofs_inode *erofs_new_inode(struct erofs_sb_info *sbi);
 int erofs_importer_load_tree(struct erofs_importer *im, bool rebuild,
 			     bool incremental);
diff --git a/lib/inode.c b/lib/inode.c
index cabe085..1fae8c2 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1326,6 +1326,37 @@ int __erofs_fill_inode(struct erofs_importer *im, struct erofs_inode *inode,
 	return 0;
 }
 
+void erofs_inode_set_hot(struct erofs_inode *inode, const char *path)
+{
+	inode->hot_rank = EROFS_HOT_RANK_NONE;
+	inode->hotfile = false;
+	inode->hotdir = false;
+
+	if (erofs_is_special_identifier(path))
+		return;
+
+	inode->hot_rank = erofs_get_hot_file_rank(path);
+	inode->hotfile = inode->hot_rank != EROFS_HOT_RANK_NONE;
+	if (!inode->hotfile && S_ISDIR(inode->i_mode)) {
+		inode->hot_rank = erofs_get_hot_dir_rank(path);
+		inode->hotdir = inode->hot_rank != EROFS_HOT_RANK_NONE;
+	}
+}
+
+void erofs_inode_update_hot_file(struct erofs_inode *inode, const char *path)
+{
+	unsigned int rank;
+
+	if (erofs_is_special_identifier(path))
+		return;
+
+	rank = erofs_get_hot_file_rank(path);
+	if (rank != EROFS_HOT_RANK_NONE && rank < inode->hot_rank) {
+		inode->hot_rank = rank;
+		inode->hotfile = true;
+	}
+}
+
 static int erofs_fill_inode(struct erofs_importer *im, struct erofs_inode *inode,
 			    struct stat *st, const char *path)
 {
@@ -1363,15 +1394,7 @@ static int erofs_fill_inode(struct erofs_importer *im, struct erofs_inode *inode
 		if (!inode->i_srcpath)
 			return -ENOMEM;
 	}
-	inode->hot_rank = EROFS_HOT_RANK_NONE;
-	if (!erofs_is_special_identifier(path)) {
-		inode->hot_rank = erofs_get_hot_file_rank(path);
-		inode->hotfile = inode->hot_rank != EROFS_HOT_RANK_NONE;
-		if (!inode->hotfile && S_ISDIR(st->st_mode)) {
-			inode->hot_rank = erofs_get_hot_dir_rank(path);
-			inode->hotdir = inode->hot_rank != EROFS_HOT_RANK_NONE;
-		}
-	}
+	erofs_inode_set_hot(inode, path);
 
 	if (erofs_should_use_inode_extended(im, inode, path)) {
 		if (params->force_inodeversion == EROFS_FORCE_INODE_COMPACT) {
@@ -1445,12 +1468,7 @@ static struct erofs_inode *erofs_iget_from_local(struct erofs_importer *im,
 	if (!S_ISDIR(st.st_mode) && !params->hard_dereference) {
 		inode = erofs_iget(st.st_dev, st.st_ino);
 		if (inode) {
-			u32 rank = erofs_get_hot_file_rank(path);
-
-			if (rank != EROFS_HOT_RANK_NONE && rank < inode->hot_rank) {
-				inode->hot_rank = rank;
-				inode->hotfile = true;
-			}
+			erofs_inode_update_hot_file(inode, path);
 			return inode;
 		}
 	}
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 74bbeda..371a542 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -61,6 +61,7 @@ static struct erofs_dentry *erofs_rebuild_mkdir(struct erofs_inode *dir,
 	inode->i_mtime_nsec = dir->i_mtime_nsec;
 	inode->dev = dir->dev;
 	inode->i_nlink = 2;
+	erofs_inode_set_hot(inode, inode->i_srcpath);
 
 	d = erofs_d_alloc(dir, s);
 	if (IS_ERR(d)) {
diff --git a/lib/tar.c b/lib/tar.c
index d2dc141..8052249 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -1039,6 +1039,7 @@ out_eot:
 
 		inode = erofs_igrab(d2->inode);
 		++inode->i_nlink;
+		erofs_inode_update_hot_file(inode, eh.path);
 		if (d->type != EROFS_FT_UNKNOWN) {
 			tarerofs_remove_inode(d->inode);
 			erofs_iput(d->inode);
@@ -1096,6 +1097,7 @@ new_inode:
 	ret = __erofs_fill_inode(im, inode, &st, eh.path);
 	if (ret)
 		goto out;
+	erofs_inode_set_hot(inode, eh.path);
 	inode->i_size = st.st_size;
 
 	if (!S_ISDIR(inode->i_mode)) {
diff --git a/mkfs/main.c b/mkfs/main.c
index c154247..7ed7844 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -213,8 +213,8 @@ static void usage(int argc, char **argv)
 		" --gid-offset=#         add offset # to all file gids (# = id offset)\n"
 		" --hard-dereference     dereference hardlinks, add links as separate inodes\n"
 		" --hot-file-list=X      specify newline-separated hot file paths for\n"
-		"                        local directory sources; local rootfs builds\n"
-		"                        resolve symlink aliases\n"
+		"                        local directory, tar full, or OCI full sources;\n"
+		"                        local rootfs builds resolve symlink aliases\n"
 		"                        (e.g. /lib/... -> /usr/lib/...) and prioritize\n"
 		"                        ancestor directories as well\n"
 		" --ignore-mtime         use build time instead of strict per-file modification time\n"
@@ -331,6 +331,24 @@ static enum {
 	EROFS_MKFS_SOURCE_REBUILD,
 } source_mode;
 
+static bool mkfs_hotfile_supported_source(void)
+{
+	switch (source_mode) {
+	case EROFS_MKFS_SOURCE_LOCALDIR:
+		return true;
+	case EROFS_MKFS_SOURCE_TAR:
+		return !erofstar.index_mode &&
+		       dataimport_mode != EROFS_MKFS_DATA_IMPORT_RVSP &&
+		       dataimport_mode != EROFS_MKFS_DATA_IMPORT_ZEROFILL;
+	case EROFS_MKFS_SOURCE_OCI:
+		return !mkfs_oci_tarindex_mode &&
+		       dataimport_mode != EROFS_MKFS_DATA_IMPORT_RVSP &&
+		       dataimport_mode != EROFS_MKFS_DATA_IMPORT_ZEROFILL;
+	default:
+		return false;
+	}
+}
+
 static unsigned int rebuild_src_count;
 static LIST_HEAD(rebuild_src_list);
 static u8 fixeduuid[16];
@@ -1557,8 +1575,8 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			return err;
 	}
 
-	if (hotfile_list_path && source_mode != EROFS_MKFS_SOURCE_LOCALDIR) {
-		erofs_err("--hot-file-list is only supported for local directory sources");
+	if (hotfile_list_path && !mkfs_hotfile_supported_source()) {
+		erofs_err("--hot-file-list is only supported for local directories, tar full mode, and OCI full mode");
 		return -EOPNOTSUPP;
 	}
 
diff --git a/tests/hotfile-layout.sh b/tests/hotfile-layout.sh
index 6af3f41..659972a 100755
--- a/tests/hotfile-layout.sh
+++ b/tests/hotfile-layout.sh
@@ -179,6 +179,53 @@ assert_root_dirdata_precedes_hot_file() {
 	fi
 }
 
+assert_tar_hot_file_precedes_cold_file() {
+	img="$1"
+
+	hot=$(extent_start /a/hot "$img")
+	cold=$(extent_start /b/cold "$img")
+
+	if [ "$hot" -ge "$cold" ]; then
+		echo "tar hot file was not placed before cold file: hot=$hot cold=$cold" >&2
+		exit 1
+	fi
+}
+
+assert_tar_hot_hardlink_alias_precedes_cold_file() {
+	img="$1"
+
+	hot=$(extent_start /b/hot-alias "$img")
+	cold=$(extent_start /a/cold "$img")
+	links=$(inode_links /b/hot-alias "$img")
+
+	if [ "$hot" -ge "$cold" ]; then
+		echo "tar hot hardlink alias was not placed before cold file: hot=$hot cold=$cold" >&2
+		exit 1
+	fi
+
+	if [ "$links" -ne 2 ]; then
+		echo "tar hot hardlink alias changed link count: links=$links" >&2
+		exit 1
+	fi
+}
+
+assert_hotfile_mode_rejected() {
+	log="$1"
+	shift
+
+	if "$@" >"$log" 2>&1; then
+		echo "unsupported hot-file-list mode unexpectedly succeeded" >&2
+		cat "$log" >&2
+		exit 1
+	fi
+
+	if ! grep -q -- '--hot-file-list is only supported' "$log"; then
+		echo "unsupported hot-file-list mode failed with an unexpected error" >&2
+		cat "$log" >&2
+		exit 1
+	fi
+}
+
 root="$tmpdir/root"
 mkdir -p "$root/a" "$root/c"
 printf hot > "$root/a/hot"
@@ -319,3 +366,38 @@ printf '/zz/hot\n' > "$tmpdir/hotlist.wide-root"
 "$MKFS" -d9 --hot-file-list="$tmpdir/hotlist.wide-root" \
 	"$tmpdir/img.wide-root.erofs" "$root_wide" >"$tmpdir/mkfs.wide-root.log" 2>&1
 assert_root_dirdata_precedes_hot_file "$tmpdir/img.wide-root.erofs"
+
+root_tar="$tmpdir/root-tar"
+mkdir -p "$root_tar/a" "$root_tar/b"
+dd if=/dev/zero bs=4096 count=64 of="$root_tar/b/cold" status=none
+dd if=/dev/zero bs=4096 count=64 of="$root_tar/a/hot" status=none
+(cd "$root_tar" && tar cf "$tmpdir/root.tar" b/cold a/hot)
+printf '/a/hot\n' > "$tmpdir/hotlist.tar"
+"$MKFS" -d9 --tar=f --hot-file-list="$tmpdir/hotlist.tar" \
+	"$tmpdir/img.tar.erofs" "$tmpdir/root.tar" >"$tmpdir/mkfs.tar.log" 2>&1
+assert_tar_hot_file_precedes_cold_file "$tmpdir/img.tar.erofs"
+"$MKFS" -d9 -zzstd,level=9 --workers=1 --tar=f \
+	--hot-file-list="$tmpdir/hotlist.tar" \
+	"$tmpdir/img.tar.zstd.erofs" "$tmpdir/root.tar" >"$tmpdir/mkfs.tar.zstd.log" 2>&1
+assert_tar_hot_file_precedes_cold_file "$tmpdir/img.tar.zstd.erofs"
+assert_hotfile_mode_rejected "$tmpdir/mkfs.tar-index.log" \
+	"$MKFS" --tar=i --hot-file-list="$tmpdir/hotlist.tar" \
+	"$tmpdir/img.tar-index.erofs" "$tmpdir/root.tar"
+assert_hotfile_mode_rejected "$tmpdir/mkfs.tar-zerofill.log" \
+	"$MKFS" --tar=f --clean=0 --hot-file-list="$tmpdir/hotlist.tar" \
+	"$tmpdir/img.tar-zerofill.erofs" "$tmpdir/root.tar"
+
+root_tar_hardlink="$tmpdir/root-tar-hardlink"
+mkdir -p "$root_tar_hardlink/a" "$root_tar_hardlink/b" "$root_tar_hardlink/z"
+dd if=/dev/zero bs=4096 count=64 of="$root_tar_hardlink/a/cold" status=none
+dd if=/dev/zero bs=4096 count=64 of="$root_tar_hardlink/z/original" status=none
+ln "$root_tar_hardlink/z/original" "$root_tar_hardlink/b/hot-alias"
+(cd "$root_tar_hardlink" && tar cf "$tmpdir/root-hardlink.tar" a/cold z/original b/hot-alias)
+printf '/b/hot-alias\n' > "$tmpdir/hotlist.tar-hardlink"
+"$MKFS" -d9 --tar=f --hot-file-list="$tmpdir/hotlist.tar-hardlink" \
+	"$tmpdir/img.tar-hardlink.erofs" "$tmpdir/root-hardlink.tar" >"$tmpdir/mkfs.tar-hardlink.log" 2>&1
+assert_tar_hot_hardlink_alias_precedes_cold_file "$tmpdir/img.tar-hardlink.erofs"
+"$MKFS" -d9 -zzstd,level=9 --workers=1 --tar=f \
+	--hot-file-list="$tmpdir/hotlist.tar-hardlink" \
+	"$tmpdir/img.tar-hardlink.zstd.erofs" "$tmpdir/root-hardlink.tar" >"$tmpdir/mkfs.tar-hardlink.zstd.log" 2>&1
+assert_tar_hot_hardlink_alias_precedes_cold_file "$tmpdir/img.tar-hardlink.zstd.erofs"
-- 
2.43.7



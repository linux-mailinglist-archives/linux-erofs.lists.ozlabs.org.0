Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6448F979C54
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 09:57:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726473449;
	bh=2e3EUUKKMGmRX7z2CVywk5vN1crgFDfQqlzF6oDKLWw=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=iE29hqqaovZU5l0y4RFP4iDRBC2giVv0akiDyCD0wqU/tr0rUJacHXfJv40Tm1/kE
	 VtmgG+5/IyNb9/Av94rkPFcSiKrGxPBCtnrONHekb9UCQ87gETDZPB0bSycyjHjovv
	 Kf3VI9WS0NbmHO+0KrVDMHW7qbqMAyL02gBzaPcFQRJCw+UH96/CAWWnsTV/Ux5HAj
	 VewaBjAtimWaqaCGMkdGXlNKq7pU9poYJoRJ66cUYIFEjqYMJwWZgNbeUXN4kSrB6W
	 hfPa8335/CAS+opb+wlPvV9mt+8N6xbcweCTgkV3cY3x/sGtg4Ta4b4E+9XIX4iJak
	 nVu4S9b/VRziA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6chT2sDKz2yYd
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 17:57:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726473446;
	cv=none; b=U1719IAsLZUXUD8pbMSlEy7WIGxyOKMfEeoGzeXM/jWAy8zImyerYJXv4RvnWBXJBH9gn7Zi5OK9ZAjiLDKMonU47an0WwC+ucaaPLRJsQ3NU4d/4R+Qp7BNtOWfrQM/JMXzAx59gWc20pukCXxx+/9oQLaveC2tw/YgLTsr/994CxKRVZT4iVnSpUx7NdbpBQ+3XIO9k/zCNjSI/LmiSgoGU5MkuFFzu/wirEAZ1Gybvr3ERrp+5R+meSyUiIKhd5kb03sNfHey1KzXQIr0rxNga97TwzIyHEFrFFGxliZbAJzKvR5Iey91qUmbYVFRQjySyD0rBJq6eJOKRX1isg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726473446; c=relaxed/relaxed;
	bh=2e3EUUKKMGmRX7z2CVywk5vN1crgFDfQqlzF6oDKLWw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=l/FpFot+j6lDzCbzjZXZzciDxjErUSGlvmz+cp7KQzEco6c2lIi4URpE89T7kGZqcmTCbzom8gPoLicVlQkL14Z8oyBi94/cnk0CfOOpw0+R8DRUBxXH+Tz52h3gnf27WGY/Zb07jYuLkabnU+sMYXbMsZcwC2TbMVnebnlM/7Ec7/kEpLPDwisPCnqYetM+EI23Pd8GQnrcAUT1l9c1gtyLDJGDQRgxO1geNtUKPWJb1yX5x7mFPx1CT1E79Ne46rF1qOjUIgFHm/3y6omsrpBEaovlfjZ3aBbYXwNhGqBWUXmL2/3A2H6JLjr51lmEbOp3moPYb7VaDQGA09hrGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=HJdzi4iQ; dkim-atps=neutral; spf=pass (client-ip=203.205.221.239; helo=out203-205-221-239.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=HJdzi4iQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.239; helo=out203-205-221-239.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org)
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4X6chQ1m40z2y1W
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 17:57:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1726473440; bh=2e3EUUKKMGmRX7z2CVywk5vN1crgFDfQqlzF6oDKLWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HJdzi4iQldcEgtr0D4pjHT9KP1O5n0e3XQhLslS55FbWCPDeOuHn65+H41WAY3v9L
	 mYAsQ27KKwrLlJ/wl6vwVgBmiFog4GPwNAhIVU0u9RbtYHw1T9mKOGrd5L0C2HhVgU
	 czF5jiNAkJKxBWUFWKmYkoQwCPCtcWdTG2Ns9rc0=
Received: from kyrie-virtual-machine.localdomain ([115.156.140.10])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id DBA8E8E2; Mon, 16 Sep 2024 15:54:58 +0800
X-QQ-mid: xmsmtpt1726473299tzlb3qchk
Message-ID: <tencent_41A044C5618690A682617E9EE23658123105@qq.com>
X-QQ-XMAILINFO: MziGzrjZeogZsgmMvHT0KZQpnkWq30hTqc8Re7SjA/1N2i1Gc3JjVTfjlinMUz
	 TGgbV19XU2VqxJNo/lOwrf0An+HRLujfWzas4ngq2Lw7pu+MwAlZFSAJ2BXcxr/SCPEyqSdIC5VD
	 cbjOOcLMBe/dczkDbcLS3EHV3xrIKCRjMHw7cBEvE2EZkBu6seEy9bLkBtORyqOPWxT3NbhRr7F0
	 R3r+SKwzWWbPm9Fis0epVSR+4anjz7bCLsgQAjNwgBDsYTEGb7gQrECXeI4TZeg7TxPom2AzbdVd
	 7/QOwcTvdvkJq9sJWH19N0x/wOplCcQZ7M4z+9Uhnr+/hxA+bCR0JD/TEMo+KWAjYcd3wvVVyi6j
	 tZfbZ1hozkeJqgaLV64V1aVvG5HTYaGTtKhWT80zcpQNNOexipGrirpt0Q3xENn9P4i7tb1e/VGO
	 7CrkG3i+uqv0lQ44JD005jDDeqDKD/YP0FguZofgXCmladORMl277XYTazACBGITqiXIJZcPA+CB
	 TsPDu/ja21R6UPst79Wl1bL5VFMmpZaWQJiua0pxEMvbYlbz9ps5Xu+wHUXiQ9mDW5q6qhU+PdkS
	 w5rGnXdTtH/gSTOwjdV4AW1XJsODM7dtz+aErYxf1tV8QkK7Zu1rWA/9Tje/wo4pn0q1vEx5jBgM
	 WYvNAHxfbewEPO0X+oqzv8qHMw5sfAJpYHb5qWgZyw/HUylBl4N5zdU9paMk45N1wLH5Pe9xkfmA
	 6st834YtmFPflzNfTBncfHT+rQt4O0eWFlz5SLMmX+0yfOzCVhmPO2oYokyX6S+pBtYjdP8XXNNw
	 heQFD+BIo5mWMaSUUpvjrlvu0CAbDyLn2/gDcOyP3NzIk54RQVj++FgMFPwuwSeDKTo42VEXG+fn
	 oR5esN6vli519I475VxhkPrkTtly/iXUEWcR681IDHgREDJgU+hC0C4+MO9XdXp84p0xJ5Lqu2sa
	 aqoQ0HKaTA5wj4BQ0A/+y1XRpx1s6SrRUIFIsuRLfaPBfeAhTO0N2fmjbfMU16NhS1AOBq8cs=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs-utils: tests: implement checksum calculation for fssum
Date: Mon, 16 Sep 2024 15:54:56 +0800
X-OQ-MSGID: <20240916075457.2448082-2-kyr1ewang@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916075457.2448082-1-kyr1ewang@qq.com>
References: <20240916075457.2448082-1-kyr1ewang@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Jiawei Wang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jiawei Wang <kyr1ewang@qq.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch specifically implements the function of calculating image checksum 
and provides interface function that enables fsck to call to complete the 
calculation of image checksum.

Signed-off-by: Jiawei Wang <kyr1ewang@qq.com>
---
 fsck/fssum.c | 251 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 251 insertions(+)

diff --git a/fsck/fssum.c b/fsck/fssum.c
index 7c5798c..c6bb1aa 100644
--- a/fsck/fssum.c
+++ b/fsck/fssum.c
@@ -255,3 +255,254 @@ int erofs_fssum_addinode(struct erofs_sum_t *dst, struct erofs_inode vi)
 	}
 	
 	return 0;
+}
+
+char* erofs_fssum_sum2string(struct erofs_sum_t *dst)
+{
+	int i;
+	char *s = erofs_fssum_alloc(CS_SIZE * 2 + 1);
+	
+	for (i = 0; i < CS_SIZE; ++i)
+		sprintf(s + i * 2, "%02x", dst->out[i]);
+		
+	return s;
+}
+
+int erofs_fssum_traverse_dirents(struct erofs_dir_context *ctx,
+			    void *dentry_blk, unsigned int lblk,
+			    unsigned int next_nameoff, unsigned int maxsize,
+			    struct erofs_sum_t *dircs, int level)
+{
+	struct erofs_dirent *de = dentry_blk;
+	const struct erofs_dirent *end = dentry_blk + next_nameoff;
+	const char *errmsg;
+	int ret = 0;
+	bool silent = false;
+
+	while (de < end) {
+		const char *de_name;
+		unsigned int de_namelen;
+		unsigned int nameoff;
+
+		nameoff = le16_to_cpu(de->nameoff);
+		de_name = (char *)dentry_blk + nameoff;
+
+		/* the last dirent check */
+		if (de + 1 >= end)
+			de_namelen = strnlen(de_name, maxsize - nameoff);
+		else
+			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+
+		ctx->de_nid = le64_to_cpu(de->nid);
+		erofs_dbg("traversed nid (%llu)", ctx->de_nid | 0ULL);
+
+		ret = -EFSCORRUPTED;
+		/* corrupted entry check */
+		if (nameoff != next_nameoff) {
+			errmsg = "bogus dirent nameoff";
+			break;
+		}
+
+		if (nameoff + de_namelen > maxsize || !de_namelen ||
+				de_namelen > EROFS_NAME_LEN) {
+			errmsg = "bogus dirent namelen";
+			break;
+		}
+
+		ctx->dname = de_name;
+		ctx->de_namelen = de_namelen;
+		ctx->de_ftype = de->file_type;
+		ctx->dot_dotdot = is_dot_dotdot_len(de_name, de_namelen);
+		ret = erofs_fssum_sum(ctx, dircs, level);
+		if (ret) {
+			silent = true;
+			break;
+		}
+		next_nameoff += de_namelen;
+		++de;
+	}
+out:
+	if (ret && !silent)
+		erofs_err("%s @ nid %llu, lblk %u, index %lu",
+			  errmsg, ctx->dir->nid | 0ULL, lblk,
+			  (de - (struct erofs_dirent *)dentry_blk) | 0UL);
+	return ret;
+}
+
+int erofs_fssum_iterate_dir(struct erofs_dir_context *ctx, struct erofs_sum_t *dircs, int level)
+{
+	struct erofs_inode *dir = ctx->dir;
+	struct erofs_sb_info *sbi = dir->sbi;
+	int err = 0;
+	erofs_off_t pos;
+	char buf[EROFS_MAX_BLOCK_SIZE];
+
+	if (!S_ISDIR(dir->i_mode))
+		return -ENOTDIR;
+
+	ctx->flags &= ~EROFS_READDIR_ALL_SPECIAL_FOUND;
+	pos = 0;
+	while (pos < dir->i_size) {
+		erofs_blk_t lblk = erofs_blknr(sbi, pos);
+		erofs_off_t maxsize = min_t(erofs_off_t,
+					dir->i_size - pos, erofs_blksiz(sbi));
+		const struct erofs_dirent *de = (const void *)buf;
+		unsigned int nameoff;
+
+		err = erofs_pread(dir, buf, maxsize, pos);
+		if (err) {
+			erofs_err("I/O error occurred when reading dirents @ nid %llu, lblk %u: %d",
+				  dir->nid | 0ULL, lblk, err);
+			return err;
+		}
+
+		nameoff = le16_to_cpu(de->nameoff);
+		if (nameoff < sizeof(struct erofs_dirent) ||
+		    nameoff >= erofs_blksiz(sbi)) {
+			erofs_err("invalid de[0].nameoff %u @ nid %llu, lblk %u",
+				  nameoff, dir->nid | 0ULL, lblk);
+			return -EFSCORRUPTED;
+		}
+		err = erofs_fssum_traverse_dirents(ctx, buf, lblk, nameoff, maxsize, dircs, level);
+		if (err)
+			break;
+		pos += maxsize;
+	}
+	
+	return err;
+}
+
+int erofs_fssum_sum(struct erofs_dir_context *ctx, struct erofs_sum_t *dircs, int level)
+{
+	int err;
+	struct erofs_sum_t meta;
+	struct erofs_sum_t cs;
+	struct erofs_inode vi = { .sbi = &g_sbi, .nid = ctx->de_nid };
+	
+	
+	if (ctx->dot_dotdot)
+		return 0;
+	
+	err = erofs_read_inode_from_disk(&vi);
+	if (err) {
+		erofs_err("failed to read file inode from disk");
+		return err;
+	}
+
+	erofs_fssum_init(&meta);
+	erofs_fssum_init(&cs);
+	
+	erofs_fssum_addu64(&meta, level);
+	erofs_fssum_add(&meta, ctx->dname, ctx->de_namelen);
+	if (!S_ISDIR(vi.i_mode))
+		erofs_fssum_addu64(&meta, vi.i_nlink);
+	erofs_fssum_addu64(&meta, vi.i_uid);
+	erofs_fssum_addu64(&meta, vi.i_gid);
+	erofs_fssum_addu64(&meta, vi.i_mode);
+	erofs_fssum_addtime(&meta, vi.i_mtime);
+
+	if (S_ISDIR(vi.i_mode) || S_ISREG(vi.i_mode)) {
+		ssize_t kllen;
+		ssize_t ret;
+		char *keylst, *key;
+		
+		kllen = erofs_listxattr(&vi, NULL, 0);
+		if (kllen < 0)
+			return kllen;
+		
+		keylst = malloc(kllen);
+		if(!keylst)
+			return -ENOMEM;
+			
+		ret = erofs_listxattr(&vi, keylst, kllen);
+		if (ret < 0) {
+			free(keylst);
+			return err;
+		}
+		
+		for (key = keylst; key < keylst + kllen; key += strlen(key) + 1) {
+			char *value;
+			ssize_t size;
+			        
+			ret = erofs_getxattr(&vi, key, NULL, 0);
+			if (ret < 0)
+				return ret;
+			        
+			erofs_fssum_add(&meta, key, strlen(key));
+			if (ret == 0)
+				continue;
+			if (ret) {
+				size = ret;
+				value = malloc(size);
+			        if (!value)
+			        	return -ENOMEM;
+			        ret = erofs_getxattr(&vi, key, value, size);
+			        if (ret < 0){
+			        	free(value);
+			                free(keylst);
+			                return ret;
+			        }
+			        erofs_fssum_add(&meta, value, size);
+			        printf("key:%s val:%s\n", key, value);
+			}    
+		}
+		free(keylst);
+	}
+	
+	if (S_ISDIR(vi.i_mode)) {
+		struct erofs_dir_context nctx = {
+			.flags = ctx->dir ? EROFS_READDIR_VALID_PNID : 0,
+			.pnid = ctx->dir ? ctx->dir->nid : 0,
+			.dir = &vi,
+		};
+		
+		err = erofs_fssum_iterate_dir(&nctx, &cs, level + 1);
+		if (err)
+			return err;
+	} else {
+		if (S_ISREG(vi.i_mode)) {
+			erofs_fssum_addu64(&meta, vi.i_size);
+			err = erofs_fssum_addinode(&cs, vi); 
+			if (err)
+				return err;
+		} else if (S_ISLNK(vi.i_mode)) {
+			err = erofs_fssum_addinode(&cs, vi);
+			if (err)
+			        return err;
+		} else if (S_ISCHR(vi.i_mode) || S_ISBLK(vi.i_mode)) {
+			erofs_fssum_addu64(&cs, major(vi.u.i_rdev));
+			erofs_fssum_addu64(&cs, minor(vi.u.i_rdev));
+		}
+	}
+	
+	erofs_fssum_fini(&cs);
+	erofs_fssum_fini(&meta);
+	erofs_fssum_addsum(dircs, &cs);
+	erofs_fssum_addsum(dircs, &meta);
+	
+	return 0;
+}
+
+int erofs_fssum_calculate(struct erofs_dir_context *ctx)
+{
+	struct erofs_sum_t ans_cs;
+	struct erofs_inode vi = { .sbi = &g_sbi, .nid = ctx->de_nid };
+	struct erofs_dir_context nctx = {
+			.flags = ctx->dir ? EROFS_READDIR_VALID_PNID : 0,
+			.pnid = ctx->dir ? ctx->dir->nid : 0,
+			.dir = &vi,
+		};
+	int ret = 0;
+	
+	ret = erofs_read_inode_from_disk(&vi);
+	if (ret) {
+		erofs_err("failed to read file inode from disk");
+		return ret;
+	}
+	erofs_fssum_init(&ans_cs);
+	ret = erofs_fssum_iterate_dir(&nctx, &ans_cs, 1);
+	erofs_fssum_fini(&ans_cs);
+	fprintf(stdout, "%s\n", erofs_fssum_sum2string(&ans_cs));
+	
+	return ret;
+}
-- 
2.34.1


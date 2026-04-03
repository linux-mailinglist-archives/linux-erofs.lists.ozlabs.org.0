Return-Path: <linux-erofs+bounces-3187-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCZkB2Mvz2nCtgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3187-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 05:09:23 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 779A83909D2
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 05:09:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn3bb4ck2z2ygT;
	Fri, 03 Apr 2026 14:09:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::831"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775185755;
	cv=none; b=OPVHiL3AJ4aeLWAT63mg0tLBfaSjoFLvlVK0M8Zx4B2IfqiiVIQEFQYCmAGxd03A3/CF/ddtDCN2hR5EmEf/B+DxL2ovSYLGHym2N1ND+LhLf9r6e0lSSmmK/GKouN1LcU++Xg0penhk2kmFj+azQrrmyO+EDNrIC+yJ4XKViu9Vuh4gWxRMR/iBVWSGbVU+PqpTh30D3xq4FX5CkETSoT1VP+JFHmpzHzIFMfbWy9pEdNNglpqJJXXbUzKcH2PCyTf0RjOl1B9L5jdPDTPMCREtNMWtb2b7NXOnzOc4xu20PBPq0632p0IMIc5febG/Diqb1se+TbnjPkucP1WuSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775185755; c=relaxed/relaxed;
	bh=lykgc06BXIBOf4QiOY++MDQGCTTginAiER02GjGA2DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iY6Z0KK6qoTVeetX53X6vmf1mVJkhPPOeO/vqWOyputvGJ0KEL2uSkzb17C8erDso2dC1jaRcgYaBx71/ElRPYKk5fN24SrUkyCTLDtUQv1gmmnmlkOiT6rV0D5yfiSPVBT+SXOG6fezMns9yI0enL6mP7HJ/zXsEXXzL9vvcV0DWkK1XcF/Cpt9XBHPPehj6tIQq6RPbwYnI6mydCKiLHFK+Xgajw3T7Qj3jwh9aOYLmFK6i1enRRCndgcQkeMY+WtHCDl5PPJEi8Trqc2RfLxX7Wywjrha7DyvifzdEoRWjsDcHiGDBSghiSdMnBIhnkveIeDkQartX3gyDCnCBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=cCgn7+Xp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=cCgn7+Xp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn3bZ1bK7z2xLt
	for <linux-erofs@lists.ozlabs.org>; Fri, 03 Apr 2026 14:09:14 +1100 (AEDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-50bbc41677dso21757121cf.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 20:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775185752; x=1775790552; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lykgc06BXIBOf4QiOY++MDQGCTTginAiER02GjGA2DU=;
        b=cCgn7+Xp1LNxr3NDsI+xC2bEO/hoyj1//c+MbPifCYRYKtdyjS8o+nbQW+alDEMVUt
         42mYLkQ9TQbUtYweub3h64KJYUZ2p9vPg8QiwCjbGwnZ40Ss+vfyGHLEMg+2m5M/Q4Ho
         IV4NBiNBdbVN21N+ZlyILdqqqNG/FPLBP1u08zxQ3hWJ4WW5tcdrqplg3VHC3MMMMbHU
         Pzl5R9tlF5nW+9ckTWtz9iYzE23nyOD0yHIxjfDfmfaOCBwTKegGlBgvh/j0rsWQwEL6
         uwy2P5L93c2ZkCowBQ+/iZGd7OdC8t8h44ks6SWsjtP9TAgUeuuMbdxMFzlxcB5JLMSD
         nzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775185752; x=1775790552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lykgc06BXIBOf4QiOY++MDQGCTTginAiER02GjGA2DU=;
        b=k6inRKTv8MbA6sNdqt5U8eQa97aTPmXuGEYRyyVIATzT3tq7o4esKcrbimm/GsvxYa
         zXmTUHXyb5oyecn9Ugg6sW3rLSSAjNFLY8g3RTFlLm+kTC3go6tc7Skzx7fM9rx3ahpE
         PB3EK4iVOG2a0+mC/q76OZnuOhunrJV4lPW55BRpHI0GZN7O3ULfbEiJRZUjvRWvN3js
         wuYbx5Gz8GX9Z7aHryAoSIkRH+qeqQ08P+x1Kc6nNkPI+1A5k5otILeThYAozidcZX6S
         FlKWps7MQ+UzMrKPfpIMlQmzpMvLsov1KeKrpP1MGljdgCBqEbI1cEXa+wmwZUB31Ing
         wyDg==
X-Forwarded-Encrypted: i=1; AJvYcCUxDtA1ob2FPCKSy+Y64lXkpIUEeK2zRX+PzW+r8zSy1tiytBqTOu7n8VBRUBGJ/tvg885exiLzd01RCQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzDuSUwZ8rG1h90f1q9hEWbtFioRAUEhOLpMzL+Y1oFlXVBvftx
	BmnKyZ7q+HrcHElnmraxmrS+3j2uk+srC9/CIfRtMWgxAIV+FHQ+/8F8upcawempOA==
X-Gm-Gg: ATEYQzyxV31xnjJYVvIDY/O9nbMYKai+ATO0oQY8CGZKZwhh0gplsqnjPplU6ud8nW7
	iIxkvJ/tNLWQEQGZKr2N4+xv0b1HmK9L90Perll1yauNd/3k7NxbKWNHNl7jhoZQbGv2xe03jZ+
	8uTdK/YRqK9Bhg0woF6vli2KYwjjbqK4KRAT9TwlKaq2lvAgHs6E2Ik0R1tMpkOelTPLChtVJVH
	wU3Bjt8CHlp6wjENiJipjRJBImJ7sVfdM+98PjrimQJuthWsFaYQwCH5uQoU/Z3/IFvwqkVGeTH
	bXK3IIFgGKoFQOShDyKJ95CNX8RWOgNJoNfzJXcrZQ2ShSLqKCdfCPM5wGzK10qlHY+Hk77ZHRb
	VKF9MbDAWx9vkgfRuIu+RoXM9ujrOmfp9vTwRWC9T7AVrNN//r7gYwIxdLBUq9u9MQG94oyoToH
	PuylF7c0iOqVo63YDC6Vt+OFH4w0WjKGi1wZR4TzCmoalv7P2ZfW2ATNBL8IR+PPiL4Rxo
X-Received: by 2002:ac8:7d15:0:b0:50b:3a6d:db64 with SMTP id d75a77b69052e-50d62ae96camr27305031cf.48.1775185751870;
        Thu, 02 Apr 2026 20:09:11 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b73e7e5sm35303831cf.17.2026.04.02.20.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 20:09:11 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect() access checks
Date: Thu,  2 Apr 2026 23:08:35 -0400
Message-ID: <20260403030848.731867-8-paul@paul-moore.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403030848.731867-5-paul@paul-moore.com>
References: <20260403030848.731867-5-paul@paul-moore.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13546; i=paul@paul-moore.com; h=from:subject; bh=yaq2D4Kebo2PkwIcQf407gzQXgOAU9Yt6G4sUCkrE20=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBpzy9HldP16eHiCJ+mwObRveQJ2Gln0HedCwxRN VGaah0yULaJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCac8vRwAKCRDqIPLalzeJ c7GLEACntKgi6d+d6yteJxF2tw9/qjnBQPa8wdrCch3KGEw0hvsSOkka+OhLqm+HXq3SUQsuMBx 5n5Yh/oYGwstW8F54Luk6qADBTv9qQxvWSw81sKVu8FWeWxxb/sUsGAjXg8unYkQCB3NWPV0F8R 77ABaWbhxecuZ6pRS/O4hrU6sbrEnC2iMaCT4RdJSWM3ldSCsf2Knr0LkauIF7/YUxm+A936xqg MTtoHYI5SQAEAtKOXe6ksnyTkUxsuVfhLu140AUwqmLGlbBeqI4nxBOaY/Qtom85nolyKhB8VA8 /UKP+CJbJSumyZGeUGPT4JOw0ZWFWZ7DdcjWKeVbHr/KRVMz82Sn49p6QJ+SEFsCcCErrV9ao+h WgWILzJJYRx0cD7kXOKbEDW9/Xp3EFRkBh5SA8F/TkHchz6I9ccUdTULu2KX17i942toKZmYaQ4 GU9y0FJ7fF/YlUn6dnrKRVHDJ+mkhQNm1/NBPHCecy61/6Ow/94dkU9JM7fw9b/d0fC2vG2Xrcd sx1pIf6eKmWkmxeD4W/HYujU3D5iyKyPq9lNqoCAjkEZXubYyYg/IqElMhDeEo+iWpIiYPvplTr 6FbzQo966xFXPEJev+9dDEEHNKdycHyesEicV97XY+emh/qleQWr4yaluTW1DqYCV1/VhLWzJ+J 0J3ayw+5K6gOtKA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3187-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:xiang@kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 779A83909D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The existing SELinux security model for overlayfs is to allow access if
the current task is able to access the top level file (the "user" file)
and the mounter's credentials are sufficient to access the lower
level file (the "backing" file).  Unfortunately, the current code does
not properly enforce these access controls for both mmap() and mprotect()
operations on overlayfs filesystems.

This patch makes use of the newly created security_mmap_backing_file()
LSM hook to provide the missing backing file enforcement for mmap()
operations, and leverages the backing file API and new LSM blob to
provide the necessary information to properly enforce the mprotect()
access controls.

Cc: stable@vger.kernel.org
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c          | 256 +++++++++++++++++++++---------
 security/selinux/include/objsec.h |  11 ++
 2 files changed, 196 insertions(+), 71 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d8224ea113d1..76e0fb7dcb36 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1745,6 +1745,60 @@ static inline int file_path_has_perm(const struct cred *cred,
 static int bpf_fd_pass(const struct file *file, u32 sid);
 #endif
 
+static int __file_has_perm(const struct cred *cred, const struct file *file,
+			   u32 av, bool bf_user_file)
+
+{
+	struct common_audit_data ad;
+	struct inode *inode;
+	u32 ssid = cred_sid(cred);
+	u32 tsid_fd;
+	int rc;
+
+	if (bf_user_file) {
+		struct backing_file_security_struct *bfsec;
+		const struct path *path;
+
+		if (WARN_ON(!(file->f_mode & FMODE_BACKING)))
+			return -EIO;
+
+		bfsec = selinux_backing_file(file);
+		path = backing_file_user_path(file);
+		tsid_fd = bfsec->uf_sid;
+		inode = d_inode(path->dentry);
+
+		ad.type = LSM_AUDIT_DATA_PATH;
+		ad.u.path = *path;
+	} else {
+		struct file_security_struct *fsec = selinux_file(file);
+
+		tsid_fd = fsec->sid;
+		inode = file_inode(file);
+
+		ad.type = LSM_AUDIT_DATA_FILE;
+		ad.u.file = file;
+	}
+
+	if (ssid != tsid_fd) {
+		rc = avc_has_perm(ssid, tsid_fd, SECCLASS_FD, FD__USE, &ad);
+		if (rc)
+			return rc;
+	}
+
+#ifdef CONFIG_BPF_SYSCALL
+	/* regardless of backing vs user file, use the underlying file here */
+	rc = bpf_fd_pass(file, ssid);
+	if (rc)
+		return rc;
+#endif
+
+	/* av is zero if only checking access to the descriptor. */
+	if (av)
+		return inode_has_perm(cred, inode, av, &ad);
+
+	return 0;
+}
+
 /* Check whether a task can use an open file descriptor to
    access an inode in a given way.  Check access to the
    descriptor itself, and then use dentry_has_perm to
@@ -1753,41 +1807,10 @@ static int bpf_fd_pass(const struct file *file, u32 sid);
    has the same SID as the process.  If av is zero, then
    access to the file is not checked, e.g. for cases
    where only the descriptor is affected like seek. */
-static int file_has_perm(const struct cred *cred,
-			 struct file *file,
-			 u32 av)
+static inline int file_has_perm(const struct cred *cred,
+				const struct file *file, u32 av)
 {
-	struct file_security_struct *fsec = selinux_file(file);
-	struct inode *inode = file_inode(file);
-	struct common_audit_data ad;
-	u32 sid = cred_sid(cred);
-	int rc;
-
-	ad.type = LSM_AUDIT_DATA_FILE;
-	ad.u.file = file;
-
-	if (sid != fsec->sid) {
-		rc = avc_has_perm(sid, fsec->sid,
-				  SECCLASS_FD,
-				  FD__USE,
-				  &ad);
-		if (rc)
-			goto out;
-	}
-
-#ifdef CONFIG_BPF_SYSCALL
-	rc = bpf_fd_pass(file, cred_sid(cred));
-	if (rc)
-		return rc;
-#endif
-
-	/* av is zero if only checking access to the descriptor. */
-	rc = 0;
-	if (av)
-		rc = inode_has_perm(cred, inode, av, &ad);
-
-out:
-	return rc;
+	return __file_has_perm(cred, file, av, false);
 }
 
 /*
@@ -3825,6 +3848,17 @@ static int selinux_file_alloc_security(struct file *file)
 	return 0;
 }
 
+static int selinux_backing_file_alloc(struct file *backing_file,
+				      const struct file *user_file)
+{
+	struct backing_file_security_struct *bfsec;
+
+	bfsec = selinux_backing_file(backing_file);
+	bfsec->uf_sid = selinux_file(user_file)->sid;
+
+	return 0;
+}
+
 /*
  * Check whether a task has the ioctl permission and cmd
  * operation to an inode.
@@ -3942,42 +3976,55 @@ static int selinux_file_ioctl_compat(struct file *file, unsigned int cmd,
 
 static int default_noexec __ro_after_init;
 
-static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
+static int __file_map_prot_check(const struct cred *cred,
+				 const struct file *file, unsigned long prot,
+				 bool shared, bool bf_user_file)
 {
-	const struct cred *cred = current_cred();
-	u32 sid = cred_sid(cred);
-	int rc = 0;
+	struct inode *inode = NULL;
+	bool prot_exec = prot & PROT_EXEC;
+	bool prot_write = prot & PROT_WRITE;
+
+	if (file) {
+		if (bf_user_file)
+			inode = d_inode(backing_file_user_path(file)->dentry);
+		else
+			inode = file_inode(file);
+	}
+
+	if (default_noexec && prot_exec &&
+	    (!file || IS_PRIVATE(inode) || (!shared && prot_write))) {
+		int rc;
+		u32 sid = cred_sid(cred);
 
-	if (default_noexec &&
-	    (prot & PROT_EXEC) && (!file || IS_PRIVATE(file_inode(file)) ||
-				   (!shared && (prot & PROT_WRITE)))) {
 		/*
-		 * We are making executable an anonymous mapping or a
-		 * private file mapping that will also be writable.
-		 * This has an additional check.
+		 * We are making executable an anonymous mapping or a private
+		 * file mapping that will also be writable.
 		 */
-		rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
-				  PROCESS__EXECMEM, NULL);
+		rc = avc_has_perm(sid, sid, SECCLASS_PROCESS, PROCESS__EXECMEM,
+				  NULL);
 		if (rc)
-			goto error;
+			return rc;
 	}
 
 	if (file) {
-		/* read access is always possible with a mapping */
+		/* "read" always possible, "write" only if shared */
 		u32 av = FILE__READ;
-
-		/* write access only matters if the mapping is shared */
-		if (shared && (prot & PROT_WRITE))
+		if (shared && prot_write)
 			av |= FILE__WRITE;
-
-		if (prot & PROT_EXEC)
+		if (prot_exec)
 			av |= FILE__EXECUTE;
 
-		return file_has_perm(cred, file, av);
+		return __file_has_perm(cred, file, av, bf_user_file);
 	}
 
-error:
-	return rc;
+	return 0;
+}
+
+static inline int file_map_prot_check(const struct cred *cred,
+				      const struct file *file,
+				      unsigned long prot, bool shared)
+{
+	return __file_map_prot_check(cred, file, prot, shared, false);
 }
 
 static int selinux_mmap_addr(unsigned long addr)
@@ -3993,36 +4040,80 @@ static int selinux_mmap_addr(unsigned long addr)
 	return rc;
 }
 
-static int selinux_mmap_file(struct file *file,
-			     unsigned long reqprot __always_unused,
-			     unsigned long prot, unsigned long flags)
+static int selinux_mmap_file_common(const struct cred *cred, struct file *file,
+				    unsigned long prot, bool shared)
 {
-	struct common_audit_data ad;
-	int rc;
-
 	if (file) {
+		int rc;
+		struct common_audit_data ad;
+
 		ad.type = LSM_AUDIT_DATA_FILE;
 		ad.u.file = file;
-		rc = inode_has_perm(current_cred(), file_inode(file),
-				    FILE__MAP, &ad);
+		rc = inode_has_perm(cred, file_inode(file), FILE__MAP, &ad);
 		if (rc)
 			return rc;
 	}
 
-	return file_map_prot_check(file, prot,
-				   (flags & MAP_TYPE) == MAP_SHARED);
+	return file_map_prot_check(cred, file, prot, shared);
+}
+
+static int selinux_mmap_file(struct file *file,
+			     unsigned long reqprot __always_unused,
+			     unsigned long prot, unsigned long flags)
+{
+	return selinux_mmap_file_common(current_cred(), file, prot,
+					(flags & MAP_TYPE) == MAP_SHARED);
+}
+
+/**
+ * selinux_mmap_backing_file - Check mmap permissions on a backing file
+ * @vma: memory region
+ * @backing_file: stacked filesystem backing file
+ * @user_file: user visible file
+ *
+ * This is called after selinux_mmap_file() on stacked filesystems, and it
+ * is this function's responsibility to verify access to @backing_file and
+ * setup the SELinux state for possible later use in the mprotect() code path.
+ *
+ * By the time this function is called, mmap() access to @user_file has already
+ * been authorized and @vma->vm_file has been set to point to @backing_file.
+ *
+ * Return zero on success, negative values otherwise.
+ */
+static int selinux_mmap_backing_file(struct vm_area_struct *vma,
+				     struct file *backing_file,
+				     struct file *user_file __always_unused)
+{
+	unsigned long prot = 0;
+
+	/* translate vma->vm_flags perms into PROT perms */
+	if (vma->vm_flags & VM_READ)
+		prot |= PROT_READ;
+	if (vma->vm_flags & VM_WRITE)
+		prot |= PROT_WRITE;
+	if (vma->vm_flags & VM_EXEC)
+		prot |= PROT_EXEC;
+
+	return selinux_mmap_file_common(backing_file->f_cred, backing_file,
+					prot, vma->vm_flags & VM_SHARED);
 }
 
 static int selinux_file_mprotect(struct vm_area_struct *vma,
 				 unsigned long reqprot __always_unused,
 				 unsigned long prot)
 {
+	int rc;
 	const struct cred *cred = current_cred();
 	u32 sid = cred_sid(cred);
+	const struct file *file = vma->vm_file;
+	bool backing_file;
+	bool shared = vma->vm_flags & VM_SHARED;
+
+	/* check if we need to trigger the "backing files are awful" mode */
+	backing_file = file && (file->f_mode & FMODE_BACKING);
 
 	if (default_noexec &&
 	    (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
-		int rc = 0;
 		/*
 		 * We don't use the vma_is_initial_heap() helper as it has
 		 * a history of problems and is currently broken on systems
@@ -4036,11 +4127,15 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 		    vma->vm_end <= vma->vm_mm->brk) {
 			rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
 					  PROCESS__EXECHEAP, NULL);
-		} else if (!vma->vm_file && (vma_is_initial_stack(vma) ||
+			if (rc)
+				return rc;
+		} else if (!file && (vma_is_initial_stack(vma) ||
 			    vma_is_stack_for_current(vma))) {
 			rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
 					  PROCESS__EXECSTACK, NULL);
-		} else if (vma->vm_file && vma->anon_vma) {
+			if (rc)
+				return rc;
+		} else if (file && vma->anon_vma) {
 			/*
 			 * We are making executable a file mapping that has
 			 * had some COW done. Since pages might have been
@@ -4048,13 +4143,29 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 			 * modified content.  This typically should only
 			 * occur for text relocations.
 			 */
-			rc = file_has_perm(cred, vma->vm_file, FILE__EXECMOD);
+			rc = __file_has_perm(cred, file, FILE__EXECMOD,
+					     backing_file);
+			if (rc)
+				return rc;
+			if (backing_file) {
+				rc = file_has_perm(file->f_cred, file,
+						   FILE__EXECMOD);
+				if (rc)
+					return rc;
+			}
 		}
+	}
+
+	rc = __file_map_prot_check(cred, file, prot, shared, backing_file);
+	if (rc)
+		return rc;
+	if (backing_file) {
+		rc = file_map_prot_check(file->f_cred, file, prot, shared);
 		if (rc)
 			return rc;
 	}
 
-	return file_map_prot_check(vma->vm_file, prot, vma->vm_flags&VM_SHARED);
+	return 0;
 }
 
 static int selinux_file_lock(struct file *file, unsigned int cmd)
@@ -7393,6 +7504,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_cred = sizeof(struct cred_security_struct),
 	.lbs_task = sizeof(struct task_security_struct),
 	.lbs_file = sizeof(struct file_security_struct),
+	.lbs_backing_file = sizeof(struct backing_file_security_struct),
 	.lbs_inode = sizeof(struct inode_security_struct),
 	.lbs_ipc = sizeof(struct ipc_security_struct),
 	.lbs_key = sizeof(struct key_security_struct),
@@ -7498,9 +7610,11 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(file_permission, selinux_file_permission),
 	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
+	LSM_HOOK_INIT(backing_file_alloc, selinux_backing_file_alloc),
 	LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
 	LSM_HOOK_INIT(file_ioctl_compat, selinux_file_ioctl_compat),
 	LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
+	LSM_HOOK_INIT(mmap_backing_file, selinux_mmap_backing_file),
 	LSM_HOOK_INIT(mmap_addr, selinux_mmap_addr),
 	LSM_HOOK_INIT(file_mprotect, selinux_file_mprotect),
 	LSM_HOOK_INIT(file_lock, selinux_file_lock),
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 5bddd28ea5cb..b19e5d978e82 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -88,6 +88,10 @@ struct file_security_struct {
 	u32 pseqno; /* Policy seqno at the time of file open */
 };
 
+struct backing_file_security_struct {
+	u32 uf_sid; /* associated user file fsec->sid */
+};
+
 struct superblock_security_struct {
 	u32 sid; /* SID of file system superblock */
 	u32 def_sid; /* default SID for labeling */
@@ -195,6 +199,13 @@ static inline struct file_security_struct *selinux_file(const struct file *file)
 	return file->f_security + selinux_blob_sizes.lbs_file;
 }
 
+static inline struct backing_file_security_struct *
+selinux_backing_file(const struct file *backing_file)
+{
+	void *blob = backing_file_security(backing_file);
+	return blob + selinux_blob_sizes.lbs_backing_file;
+}
+
 static inline struct inode_security_struct *
 selinux_inode(const struct inode *inode)
 {
-- 
2.53.0



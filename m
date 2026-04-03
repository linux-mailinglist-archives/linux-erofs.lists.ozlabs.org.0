Return-Path: <linux-erofs+bounces-3184-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAFFO10vz2k3tgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3184-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 05:09:17 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA3E39099C
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 05:09:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn3bX1yqkz2yh4;
	Fri, 03 Apr 2026 14:09:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::834"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775185752;
	cv=none; b=BQvgXmif+zZMB/GR9aW057hObfSiKD4qYs0cCpPEwy27DIa+10hZi+37b1fUBhXcUyAhlXn9L5+m+osSIxyHqn2sEggxSYtWGNOWBYpqErL/c+JwTByqf4zcA0gz0AE+ifwR30cHnKsw5x45PAMvtPfPGguUJZoyEkRDCyDlm23C0tD491kk0wnVa2RrAsBrbB4pc2hMgQV8wmSC/DOQgt2wZ+baCSg9VQi7fBzGe0qWRkyVXd/1Gqcmc+tGDYQtMIrl3P5euThZsAO9laZ04s02D7JhmYEKZmMBfdGTutaoVaMN5GWJbDc7I18/RXO9IZ9SAs3EfgXzb0Ie2Mxvug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775185752; c=relaxed/relaxed;
	bh=K8u86zVn3x5mfnTbqvKyzgu+ADF1ErhB2fVGX96rkGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mx3LMpeGQvwRI3Nrf9EIbFATWbVFBj0PHfHTaGjXx9yV/9/vFSLAf7vyj8falQmJmrf908xKQu4ilexusBZwoJtyi+U71YhcM7WmIuUKCurGVNtgLZ6H/UpBUXFmo/CqE/h1Ja9x0tjtCkMm1PoNlCHUUoxLpNuVX+mLgIMwtwGvMbeHvOU/QlDu3OJb5HPSsDCq1nf3MK1BxEQlsljJ9v8zkWrEGapSIWKLdFiLNW7YRdWTsbQlG7JYxpzggCCHJPFY8NGjYgZPoo90+XPqBg6K84BslgmJxZUxvhCsMF0hhcSkOuNdj9PHUodt82MCNEza/eE/vN216VeQJQ78LA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=SKw+x3LY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=SKw+x3LY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn3bV4Mp5z2yVP
	for <linux-erofs@lists.ozlabs.org>; Fri, 03 Apr 2026 14:09:10 +1100 (AEDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-50b69bf5638so18228141cf.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 20:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775185748; x=1775790548; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8u86zVn3x5mfnTbqvKyzgu+ADF1ErhB2fVGX96rkGw=;
        b=SKw+x3LYcTakpvqxgbqGD/+hglc/BqyA5AyYSsF5DD6Hsxw03YM8hhFOt1tdnRRJTp
         bG4IYGFHe56WJ1sTBs0E6WVYyfjKaHxbBNhQOl2Dxd9MJ2PdQ3mItV+2/FKZmcV5qKXM
         EH1/j6mPo+b+JEKVrLbPlmkvvA9jKFeui39LmYT0Z1fop5LieOfbIY0DeFG0s5+m9HXM
         gzhRQG5NLsC9nCE+vJCWXZqMXePCgXbl3lFTkI1aCu0HuKpew3XKy+BGmq/6fSwDYp8R
         xsJzGhwBy4qbYiPPwiiSdSXcOkalffjckaeC8mJpLivEnny8vKr4iNavjj3lT6Xc7T3y
         EA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775185748; x=1775790548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K8u86zVn3x5mfnTbqvKyzgu+ADF1ErhB2fVGX96rkGw=;
        b=I0KhvEPEAUYP/lFj66qw/d9GUr+i+yiuJJ0aT+UCk4K0mRBqn01UXJtFHUtHg8CKM3
         BVJOA9lPjlwZ9C+kAvA3F5aPn6FhofiSNQ92I+bOKwtUGPjBLo7ADWnVP2C6G36aLOtX
         44Ix2zA5C0R5NSAkQ+mei/UN8vd2Kyf6qyCz+i7Yi6W6HihnoGXCso4kywDFwDYIVACb
         SrUFf51Mlh0urrJBbRoNqW3LpH1lDovLWbebSGc83k3JC3O0QC7wYjgYyttJukPofaQ1
         aaEGOXRaKMTKdNXxx08fumUsiYGG9hid+JgInOqL6JrBAXGYu4V8TIFmN6NiTijCbZsK
         eW2w==
X-Forwarded-Encrypted: i=1; AJvYcCVI8bSc/cOJX9+d7ORrej0iYRJXRqAOY9qiRbgRjz0Nhnp9XWFPa11diNpmEnMOTKwxuFbTCaobRwgOrA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyqBlk90wXsiul/DyhPK193/5RT22IlOvVFgRDLGRfIwU1t9lWA
	b0yzYsXTkL2GoapDrpHVeAT0Z3clP0SbV3wCXchQv+v/zqOkjt1A8g29zToHXTt1Nw==
X-Gm-Gg: ATEYQzxrRUeHiFow8DPmjIufsdGQ51h3kyln0FAVQWBh2PJCb1O5Ox58MTOLDMMedkq
	S/lW1/t1+MKpxF9QxZGIh+ecNeBMmbVweDKYEz24ealhoR8zJ+l3nuwnkZwucGqMtz38rgqtV4M
	7juGnZlpywQD9RxaczEJXxuNEo0bt/RZpxwWst5bZffcecLocc0U5gYp50rZnmr+qFd+Y1AW0q7
	DUd738m63/9JV1gMXV8OMzC5bdaLU5VPlkT4bWDcLQf9Xm3SNXNPW9UCNiV701ss/EoEGoG/EaM
	e/KUlxUs6IZphnOOp9mi3XtreG9qV83CqfeuNsbwaiBTHD2xJ6gUV72P8Ax0HonPhlqVsHMd4e/
	frU6O+EYyQghjC8Y6EzvL3kCOuFiqqpbGmYuVKV2gGe95ROzDZsbE86tveghpQHOBRaKQ4TovH2
	XoTJo97fhPrH/Zm+g1kA+pFo17CbzADTpx/41RPzsNKLU7wDgEshVz4Pf0LvUTR+l0A/UZ
X-Received: by 2002:a05:622a:15:b0:509:1cf9:ea0e with SMTP id d75a77b69052e-50d62a80ddcmr26975991cf.41.1775185748160;
        Thu, 02 Apr 2026 20:09:08 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593ded920sm37724896d6.21.2026.04.02.20.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 20:09:06 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v4 1/3] fs: prepare for adding LSM blob to backing_file
Date: Thu,  2 Apr 2026 23:08:33 -0400
Message-ID: <20260403030848.731867-6-paul@paul-moore.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2201; i=paul@paul-moore.com; h=from:subject; bh=vO4j5WeMDF8uCaEs+Rdi7vAE5nsJDGp7MtIwbA6jMDM=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBpzy9ABnm7o+Z/R7KK/xs51rLx8PxwZiwo+kbgY FAsqRG/RIeJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCac8vQAAKCRDqIPLalzeJ c0/iD/9AMU4LuXIflLPn+lMMYMXL4wz9r6vZ2+IPv39vdupeEEtbP25ysV3gOBT/AMCJr0YZsyJ nAA+n8pMAjlgBtJIk4TWLq7fpPB0T8u9E0JMzT9gZnOCHnqlqc4ydP0gySv8oT5rkfdlOaWBbpA gZe1wqNYP2HK1Kad7uVTVFets5abIwjgXwzPdXgMV9b/PFeXrp8fedOIAR8WBdlAD1I41BW6IDh HakWAR9mdWgZ3pLFsxddxWCu3jcTQnJ5dbOjjZ5//cWmwt+PKcBsu9PlkjfOPkzaMeJf6BfgLAW 5QukV/rYK3H1Dc+TeuDdbT7HI1cFzi7Xpz5LeW1IFzYyFByGryq3ug1tpSpmMQLUOZzDWARemhj gcqAU8aaBhMkclqN5XrJRdOdkxQJQyXgu4FyOsQ88DCAc6iqS9pTaXO7MXzRFf+Dy65Ue+LfpII d0ryWB+t6fWIUFbpD6lBPVhQGtjc/NI/u1jplqW58aA1T5vqMzmjEMatMUBcG/l5OyspEAsIlka caOfuNSjXvwX1j5JCPbkF1G+yT7fdc9g2D2pu0mIfxcJrUmy7Ti6uxndL6rt/qFXk/gFcbBpaVK p0Ow1dUry8bLwkwqcLWs6Q0F2SR4JIX8e/mNA5jb4FpnBSDrrD5V0+4H20fVhTMfuNcKYskg+Rp pRUE5uqRW8k9irA==
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3184-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 0FA3E39099C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Amir Goldstein <amir73il@gmail.com>

In preparation to adding LSM blob to backing_file struct, factor out
helpers init_backing_file() and backing_file_free().

Cc: stable@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org
Cc: linux-erofs@lists.ozlabs.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[PM: use the term "LSM blob", fix comment style to match file]
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 fs/file_table.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index aaa5faaace1e..3b3792903185 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -66,6 +66,12 @@ void backing_file_set_user_path(struct file *f, const struct path *path)
 }
 EXPORT_SYMBOL_GPL(backing_file_set_user_path);
 
+static inline void backing_file_free(struct backing_file *ff)
+{
+	path_put(&ff->user_path);
+	kmem_cache_free(bfilp_cachep, ff);
+}
+
 static inline void file_free(struct file *f)
 {
 	security_file_free(f);
@@ -73,8 +79,7 @@ static inline void file_free(struct file *f)
 		percpu_counter_dec(&nr_files);
 	put_cred(f->f_cred);
 	if (unlikely(f->f_mode & FMODE_BACKING)) {
-		path_put(backing_file_user_path(f));
-		kmem_cache_free(bfilp_cachep, backing_file(f));
+		backing_file_free(backing_file(f));
 	} else {
 		kmem_cache_free(filp_cachep, f);
 	}
@@ -283,6 +288,12 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
 	return f;
 }
 
+static int init_backing_file(struct backing_file *ff)
+{
+	memset(&ff->user_path, 0, sizeof(ff->user_path));
+	return 0;
+}
+
 /*
  * Variant of alloc_empty_file() that allocates a backing_file container
  * and doesn't check and modify nr_files.
@@ -305,7 +316,14 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
 		return ERR_PTR(error);
 	}
 
+	/* The f_mode flags must be set before fput(). */
 	ff->file.f_mode |= FMODE_BACKING | FMODE_NOACCOUNT;
+	error = init_backing_file(ff);
+	if (unlikely(error)) {
+		fput(&ff->file);
+		return ERR_PTR(error);
+	}
+
 	return &ff->file;
 }
 EXPORT_SYMBOL_GPL(alloc_empty_backing_file);
-- 
2.53.0



Return-Path: <linux-erofs+bounces-3205-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKBDOPkB0mmiSQcAu9opvQ
	(envelope-from <linux-erofs+bounces-3205-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 05 Apr 2026 08:32:25 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF6539D81C
	for <lists+linux-erofs@lfdr.de>; Sun, 05 Apr 2026 08:32:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpN112Fksz2ybQ;
	Sun, 05 Apr 2026 16:32:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775370741;
	cv=none; b=YcGy1jwOkIhs3uhKlZjwr9ModdNjzjhfdin4nWufT3YE2XRo0wGLBe+N+tdH596fv6S6u1u4a4uLyZ4u4U83vi1HyNIYoSWRUA38AvZepAci1YHQzeJ+uCM3P2lpCuUNyVHh3DJHwOQgaaL+S+2uWHuJPxdklI37xnHBHGnUfCCZZHvhVFMthwpdTLC8cnH9luQjqAzNPlHSnqODGGCiJuE9SiHF2xO7TkfQXATvhP9u2joLeroNRiwLWYg44ih6I9jrXWeaU7Piy9acFnDcW7UyY2dsACcn/lxOmPscWmZMPiF/7dmE+JcVg1VwltdweKTdGmRUDHGCkstoXEjHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775370741; c=relaxed/relaxed;
	bh=rGverVw3ruaa27eKzcrp33L0r+CJsGIyeXbu41LAjpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEF9hmS1nxhTfyBiIB2iJ2Vzmo5luSZ9FL7J3WG0b1mWnta/RjsiMqHw9NJI9cXT/K/c8zvCcLfpN8kLMYPpqzmIXEFtE1HlpdWLod6b74cXrZKaIgcDdJzOJ78uQxeayzs+IgN09syny3J8FuvmzEKRUM8qZJsER6QrYrl+mBsdKkVHgR84b2Tu38L1dsdmZt7vDWcQrTmCaigSA6lHjZlGhjvhDUbMtd7KzIq6oxuNkuFdpvSj8aAC6QLSrnb49FsK3rH171nBIKMETiA+0tSbg8EjkuzRl4tjelboX77O09n7mpzg02vPkiJ55PYquHzRoLazKU2cE/h74FTi5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k5ONQxTZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k5ONQxTZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpN100qm9z2xSB
	for <linux-erofs@lists.ozlabs.org>; Sun, 05 Apr 2026 16:32:18 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so1068575a12.0
        for <linux-erofs@lists.ozlabs.org>; Sat, 04 Apr 2026 23:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775370736; x=1775975536; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGverVw3ruaa27eKzcrp33L0r+CJsGIyeXbu41LAjpw=;
        b=k5ONQxTZypkMjq+9/nGOugxYQ7h15xB+E3dFrCANQHMVTcA8uQmLXWggBXctxsSROQ
         fYFY/w+tCIboc92Tpe+9IrSeIKFbzYcfMZdDFboblsf/92iaNMiGdWMPbe+K3vu+QLq1
         RFeDVnROCSxbv4I7QqVCP0MKkHCYf30BYxHOSNXjdyEieSeGx8xFYlUcH6jYG+mP/41I
         LkJBPw2dCPvOPtfL6u7jC9QeAhTcCkl80pn/fUDScUd2eeWzLuok446Md4vDjxKY02jt
         LhX1fixALtxQbH/IXKowRY42tQE9ytzykmX3q/cJYHGFpZgfeLOBAnMlnBMjJ1CXggaG
         7U3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775370736; x=1775975536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rGverVw3ruaa27eKzcrp33L0r+CJsGIyeXbu41LAjpw=;
        b=OA70Ji+/lI8pbMBSQN0hSdes3zAVtrVtpDor4FgwXFtjJbAEeCLbUWni969ZY39LFz
         bqaWIFMM4ABv+FMPpgOQ1EmW971gziWPVTLKd9VB+t2WxkLTTv6SW4d/I3StttiC1si3
         dFJLKw9rfY0mtGiyHm0Y8l3yYM8JEaYsoA8L/4ChHWV7vy2NuJICI64WZZAdiG4JzWdF
         Tv3lGDlifUiXqv7IUVguX3FqdRw4npK6eioXn7A5wxPq4I0rHcIy0Ps2geyFadGhl/Tr
         2VQZwqm51Lo3ishK3mAttEFeUs7/WVIQw3FsbPFSA38t3UOslHnmFb1ggT1gsedpO7e2
         RtpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlmwcJwnxWDU1whBybiyfAFUod8e0YRe0kqAnEnkm6ZVeBREetZ6IG5SpE/1JWAiMBeYoeaSe77Stp+w==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxO0ZumXPmdOx/FknULGayPdUI1KRKS96X04bW3mOKsf9108yuR
	bILwsd63KawYG+36RC3WibyT3RzIbKR1WczD5G0GtSVto6IA0jS386Yg
X-Gm-Gg: AeBDiesl8+3WvjjtIphjn4Lcnfe0EXoQ/kv/1mFFiMOyPp4gdxBOYQscGyuf7n/0OGh
	wH9rOHR6NVmhcyJG+vbUwS2EpYrzuvT2uKTGknHzuynh/OOEr3pmgmz6L62zK71PcxRMi2kSjmp
	oTZRoYVZF7s67CVu6VC8jazv6UomLkBFc2BmwGn9oR7/NjiXRMnd5etotoTZHaKXQqPVS9a1+gl
	Fg4bnYQlc531VU7UbtaqdXSK4SowFVK7qFga8U/hgM1+f9toazkUqU1YOCvBYjEm5uEDRRbU6iK
	TdGwN0BnAyej4Q9nHI1xe1VQEZ/3+f4KObWLmxNeLF8XQAlswnZqyCx3lDOHYehOkUzHkq1/iX1
	koYqUic2+UU7TADBthmw1YCt+dsT2KKhIsOUeU8heiUV2OynMmsfRorjLytFZKhlo8OTfhtarAW
	VpyCoTXrRx++vqJmLOx7KaZvihQYV3G/nIWZls32EM7dN7DzuBnnvW5tA5
X-Received: by 2002:a17:902:d512:b0:2b0:5a4c:726a with SMTP id d9443c01a7336-2b28188fe18mr89553505ad.43.1775370736513;
        Sat, 04 Apr 2026 23:32:16 -0700 (PDT)
Received: from localhost.localdomain ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274978fd7sm131808425ad.39.2026.04.04.23.32.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 04 Apr 2026 23:32:16 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: nithurshen.dev@gmail.com
Cc: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	stopire@gmail.com
Subject: [PATCH v2] erofs-utils: s3: fix memory leak in s3erofs_create_object_iterator
Date: Sun,  5 Apr 2026 12:02:08 +0530
Message-ID: <20260405063208.4617-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260404082737.87032-1-nithurshen.dev@gmail.com>
References: <20260404082737.87032-1-nithurshen.dev@gmail.com>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3205-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:stopire@gmail.com,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[linux.alibaba.com,lists.ozlabs.org,kernel.org,gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 1CF6539D81C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In s3erofs_create_object_iterator(), if the parsed prefix length
exceeds S3EROFS_PATH_MAX, the function aborts and returns an
-EINVAL error pointer. However, the 'iter' structure was already
allocated via calloc() and left unfreed, causing a memory leak.

This commit adds the missing free(iter) call in the error path to
prevent leaking memory when excessively long S3 bucket paths are
provided.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 lib/remotes/s3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 768232a..abfa5dc 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -911,8 +911,10 @@ s3erofs_create_object_iterator(struct erofs_s3 *s3, const char *path,
 		iter->bucket = NULL;
 		iter->prefix = strdup(path + 1);
 	} else {
-		if (++prefix - path > S3EROFS_PATH_MAX)
+		if (++prefix - path > S3EROFS_PATH_MAX) {
+			free(iter);
 			return ERR_PTR(-EINVAL);
+		}
 		iter->bucket = strndup(path, prefix - path);
 		iter->prefix = strdup(prefix);
 	}
-- 
2.52.0



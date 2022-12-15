Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2059464D6A1
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 07:48:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NXjVd6VXzz3bh6
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 17:48:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=TAbdygIu;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=raj.khem@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=TAbdygIu;
	dkim-atps=neutral
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NXjVG2Xhvz3bSk
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Dec 2022 17:48:06 +1100 (AEDT)
Received: by mail-pg1-x52c.google.com with SMTP id b12so870144pgj.6
        for <linux-erofs@lists.ozlabs.org>; Wed, 14 Dec 2022 22:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZ7hxoKNbTjaybD4RlFEQkUEwp1y3rxCjfROeQyRoZQ=;
        b=TAbdygIuc+HiQmFgvPcbXRggktUnGARZDX5h0+MnQB7vIjg7O4Eb3xqmrqga6XNKDq
         wxzEA+NW5XhF49yOIdcDr9xxHaLh6lbDovEXVaJOKYfJCBM5a852dXbepYO5/buinmD1
         Wk6b2OX7UCScjqK9GCFYREa9G4P27f/nMgIhNNR0DPTjfGuxhikHYOIubhrd/oUCXuwv
         8ULHcM4YfWEYlhIrxZy3kOHG+RLU54mVei2yZk73Y5jPgpypSgUhfTwabXR44gAvQ6g9
         on5ykjkBDGZqFAbeSYFvtqm43rh4leWr4Ioq16JVzJM/kLaWksk/beu0BamVhdEeMAr7
         FiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZ7hxoKNbTjaybD4RlFEQkUEwp1y3rxCjfROeQyRoZQ=;
        b=NBJm0wCnmuOzmsOaiepaF7O7IEmhtCbcDCfAIbbMqlyBZR4bF8zFI93B3d0hg/O22d
         6Qi2xFyAKWOny1ubbzCNiGP0o6Y8vNPQ7wxy0+9Haz/8s1vGNn9ciWioTLoOhWLi/oyy
         PEjvftGJKh+bfyTcGXFCnGOe/sl3O+bUC6V3zSAMRgBfvWwFzO2bJWeenh/V/7+r0+Lo
         QPdovm1DorZyzV5LaxvXrIDVAF2nhHcQFQKEioQgqAFVj04DSrZLLknSb4SPxea4pHyN
         VJBTuoiGYhbuYDmQDzxPmZ7F2v3nK9iQVMw7eDd55uh5vnZMKNoVoVcgbamJnWpAl7Gr
         aybA==
X-Gm-Message-State: ANoB5pnt0uezBsODW3jCoornac9vSP4FXXh+CfKqkzQRJ77wCvQpJGT1
	36G7NM0UOP3IEjVZKR8+2N9FgNYVt8s=
X-Google-Smtp-Source: AA0mqf59LXgnsKB6fqvVLZbpcsltMr/d7lH6t15bwLjYRKp7cCAUJLSt9pMqoBb3Wb6IWNKGipb1Bg==
X-Received: by 2002:a05:6a00:1696:b0:56c:2049:f55b with SMTP id k22-20020a056a00169600b0056c2049f55bmr36112436pfc.26.1671086883793;
        Wed, 14 Dec 2022 22:48:03 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9181:1cf0::7d9c])
        by smtp.gmail.com with ESMTPSA id c202-20020a621cd3000000b0057524960947sm926689pfc.39.2022.12.14.22.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 22:48:03 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 3/3] internal.h: Make LFS mandatory for all usecases
Date: Wed, 14 Dec 2022 22:47:58 -0800
Message-Id: <20221215064758.93821-3-raj.khem@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221215064758.93821-1-raj.khem@gmail.com>
References: <20221215064758.93821-1-raj.khem@gmail.com>
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
Cc: Khem Raj <raj.khem@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

erosfs depend on the consistent use of a 64bit offset
type, force downstreams to use transparent LFS (_FILE_OFFSET_BITS=64),
so that it becomes impossible for them to use 32bit interfaces.

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 include/erofs/internal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 6a70f11..d3b2986 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -21,6 +21,7 @@ typedef unsigned short umode_t;
 
 #include "erofs_fs.h"
 #include <fcntl.h>
+#include <sys/types.h> /* for off_t definition */
 
 #ifndef PATH_MAX
 #define PATH_MAX        4096    /* # chars in a path name including nul */
@@ -104,6 +105,10 @@ struct erofs_sb_info {
 	};
 };
 
+
+/* make sure that any user of the erofs headers has atleast 64bit off_t type */
+extern int erofs_assert_largefile[sizeof(off_t)-8];
+
 /* global sbi */
 extern struct erofs_sb_info sbi;
 
-- 
2.39.0


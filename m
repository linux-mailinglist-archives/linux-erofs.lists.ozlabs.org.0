Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A11D949F298
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jan 2022 05:50:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JlQ4h3xsxz3bPR
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jan 2022 15:50:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=GBoFDd+G;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::336;
 helo=mail-wm1-x336.google.com; envelope-from=igoreisberg@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=GBoFDd+G; dkim-atps=neutral
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JlQ4f261Pz30Kn
 for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jan 2022 15:50:26 +1100 (AEDT)
Received: by mail-wm1-x336.google.com with SMTP id
 k6-20020a05600c1c8600b003524656034cso171183wms.2
 for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jan 2022 20:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W96Eeqy/1wfbpjTDwK/azFrL4JVTq+xlvOe35AlihkE=;
 b=GBoFDd+G5XV2LKnc7KqG6gNt4wkBucVvapnW5PiPo1bQSwnJFJvt++WQynAiJeQsZD
 7agReK9zqfcKqNPooNQ4i2cCUjmhPUby3rTA/VpAZ8AxbqVuCVhBbQG7UB40jD8UGMBA
 foNeIqM5mHvnG5GU5FfXT0jQ6mlfHM5pRUlkLCQLmEPvKFY2mySgD2nyieULamfnbLyw
 8R3teAGTQzBq1ovKP/UZCDmUW7VyTozoybpdvKElUUVqqh8Lns3AzYlWW4msGDQREK6q
 EDdpMuTUmSbp9G4/NMHos1xO8iLibYy3ialesvxF5sMxJdtlbmcABgdWyT3vWCplsUYk
 qpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W96Eeqy/1wfbpjTDwK/azFrL4JVTq+xlvOe35AlihkE=;
 b=htYanOx9I2YMzioi+C3hK2rweN4tGWX9VfzhU00FKQvgPET9OzxpIC+YaZmNucGJSS
 Uhnjh0jCtplY7C6LFFmTI+LC+NOQgLOeDqavf61kTEQJZwFFPhdGpJCXriqd8JjEO7ZM
 f6w0/NnkmUssgwVqBqvK9wBWiOJAswlIOlN1zXyn/QGe6j6x0nEYc9ZOIrJbFLHM1Zpn
 3+9fKE5PvpFQY9QORktGlZhnXSXKWCp0O51wQjrXHOANxKiLfrhFYDbxAZbRI8KvErMv
 oWN4Vz1n3wW4DyrUYfXyM6Z29JEiSyjEMPLJUuwh6AzsCzC/Jces5W+qZ/39dcwNC2AY
 jkSA==
X-Gm-Message-State: AOAM532U/2YuH3NDGbuT17XszzWt+8qfd7vEqLA9iS+zGvU9JzbabKoO
 2FVL0MzzMW4k9AijpRQsZDXHs5ftyHBvqQ==
X-Google-Smtp-Source: ABdhPJxdM+SEoHotbO+R+AL/5G3WvLqSRN1R1RxmgSlbCVhFDXveZbgfd0UATMTzjda3n2eu2fd4FA==
X-Received: by 2002:a05:600c:28cd:: with SMTP id
 h13mr14629873wmd.54.1643345422024; 
 Thu, 27 Jan 2022 20:50:22 -0800 (PST)
Received: from Iceberg-PC.localdomain ([185.110.110.225])
 by smtp.gmail.com with ESMTPSA id g13sm3899544wri.50.2022.01.27.20.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jan 2022 20:50:21 -0800 (PST)
From: Igor Ostapenko <igoreisberg@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fsck: fix issues related to --extract=X
Date: Fri, 28 Jan 2022 06:50:18 +0200
Message-Id: <20220128045018.26-1-igoreisberg@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YfNvloN0RAX0mHRn@B-P7TQMD6M-0146>
References: <YfNvloN0RAX0mHRn@B-P7TQMD6M-0146>
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
Cc: Igor Eisberg <igoreisberg@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Igor Eisberg <igoreisberg@gmail.com>

Fix compile

Signed-off-by: Igor Ostapenko <igoreisberg@gmail.com>
---
 fsck/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index 2f13870..6f17d0e 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -196,7 +196,7 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 			return -EINVAL;
 		}
 		if (fsckcfg.preserve_owner || fsckcfg.preserve_perms ||
-			  fsckcfg.no_preserve_owner || fsckcfg.no_preserve_perms) {
+			  no_preserve_owner || no_preserve_perms) {
 			erofs_err("--[no-]preserve[-owner/-perms] must be used together with --extract=X");
 			return -EINVAL;
 		}
-- 
2.30.2


Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D17698E1D8
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Oct 2024 19:43:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1727891006;
	bh=8AEdD+3/490HDz+pWc5YBIQA1pEFhZdxdnYZKQxLPPE=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=UZepNj4x+Z5Ltf2FpI72cnDoRarkXn9MTlwNwTsoh0iBonfkFIx2Yn/FW84xV3sLk
	 OOoNRaFmp5jtFYGoDcNncBsaYkEsB8kDFtVkpd6gE35YLwkIgvsBgtsUclHmUVbJu+
	 VOZbtjMYY33O6OwmDGYucmbBm+x0rSCmAb+QRnhVzSVUJmMUCr/qVUzMxaqkgTIMsZ
	 zy3RckF7rtx7ACYJFqFPq5MXAE+FwVsu9cDSrS3jGHNdYkxFY78MLZW3ed54whrz84
	 I6N2rNWfGXDy69Sr+zEsDRTrF0FyspL1ttQndnYLddpggSHTRGrk/Z914+bPKItH2v
	 7DS5uvo5I2iWw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XJhxB64sHz2yWK
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Oct 2024 03:43:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::649"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727891004;
	cv=none; b=dT7SU8OZX4JhMWn32IgC/dkhfy/QZQ97iU8gEPc1TwdsNpWqjJSGFRsEahgd0PssIEv646jRROkcPd7uLnncISTomIXa4SbkW15awg7vV0d8U1EKpoWwHuA9o4ARbi2+hMwXOr/VkaV7674Khdmb0YqW9an+QilXiJmHc6uwxPVBcmHr193+Gixzo2MXqanJZKpflbn6i8ZMsfkKxoiU9fBkeIHSd8w0tGSKhp9y4s/BwxmL6A4NHCyop/Mz22g1Z2qOAbjQsZRulRK2cISQQCgP6Ic3yKewVgaVRsHQTuWH/wn1i2Rmq8hKIfgsrGb6O+Q0ItWytp49A3Ldkqd7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727891004; c=relaxed/relaxed;
	bh=8AEdD+3/490HDz+pWc5YBIQA1pEFhZdxdnYZKQxLPPE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FAy0YKv/oxpOoYA+awsu2NYO0mVC64wIqtXSjkVtUwBZDIDjsMI6WXl2y0Vp/JIQq1pm2e0DwCqGWMbKkcmO4WNK+AJPRn7f4Tg3uk8sFTaDiOZilXb2a0ayS3x0b/VqmOPu61o8RgiGVzuywJgvDeXXYXJ6QKG3dzavtbVX/fQyVWPFDZDLOh4BQP5mApV1KEo9CmvrGtHySLABC1AlSTkJRrRBEYEsCoIujuqR2TodNOMQJJxEamXcPK9ZLNl427O4x3PIA1UHo+O6ow7LSFgtV2BZjdyPTdmzeZkPNipxVZjnKpe5ZY5PjzVZbVQ+SFMZJgYChSQht7AxvWEXkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=fFxH78MZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com; envelope-from=3nib9zgskc3usatgzdxeobgzhhzex.vhfebgnq-xkhyleblml.hsetul.hkz@flex--zhangkelvin.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--zhangkelvin.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=fFxH78MZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--zhangkelvin.bounces.google.com (client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com; envelope-from=3nib9zgskc3usatgzdxeobgzhhzex.vhfebgnq-xkhyleblml.hsetul.hkz@flex--zhangkelvin.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XJhx72QYNz2yN8
	for <linux-erofs@lists.ozlabs.org>; Thu,  3 Oct 2024 03:43:21 +1000 (AEST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-20b921fa133so1269545ad.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 02 Oct 2024 10:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727890997; x=1728495797; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8AEdD+3/490HDz+pWc5YBIQA1pEFhZdxdnYZKQxLPPE=;
        b=fFxH78MZ30C8Ms9L1LhNnjcXcwLVXUJL0tYYpNNQnpba4vlo5yFaAApvfQy65+S3OP
         l5g2bUA1j1YWBa9MYJZMICqRDzxuZBQiSCo5YKIhsGMRRxPQXOvs9Hvxytaj5gzcE8ZH
         1KVZc/iUT2bwFi5C2WqNoy3cBkngxMQQ2StO77GOtMHxxo8M0xtD3RFMnmnUWdPdOeIU
         EC5i941F0+5NiaN0GisuXAITUST0qFn32Q9jBeJ+6pCEAtugp4l+D/KUApb1Hti3CaPx
         KnKMIvm6nq+tpz3cDCKE3nAPZHAtVXzMzsUE58UhQccsyFlr7U4jfSFlw0xdzk+hx1Ew
         LvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727890997; x=1728495797;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8AEdD+3/490HDz+pWc5YBIQA1pEFhZdxdnYZKQxLPPE=;
        b=Z2XUPqJZFa4PYIa01cn8froJoyZTpEUSzFUCV5uvNFad7qX0w2Blpgel28bEWiMZcb
         RwRkI4oZW2FGiHvAqorIeOvWA5VBDQvN1zMSXvC73EAF4kPyz9hNufUow2jilCbrsm+J
         b14X5/KTE+wVR0ZhyBW+EiISME0RbydfmQBrnhsKqy3XEyUmRzNTVN5R1Lddmstvw8cG
         /tB/PitlIW0hTIqL7QTlAQ7oyH4O1L8kSlF+Kwy6enh96m0FsKYi/hHVrHLRBP5bnF/W
         ujs5nOAOoWPhhd6XmR56TO0FfC6cHIQtJl+zOs70nBjO8DnEoVg5h4rS6A7Jwe7KeP6K
         cLww==
X-Gm-Message-State: AOJu0YwdIsC2oYa6Oo8trR/XWgKqsiRCDVA6uRZlBCUNDQGMMjeX4OJd
	oyQEHD2OlbMnYA2VxZP/OocvdROaD/gyba0Qtef/lc3yb/MR7KrQT/NAZDIMV7A7PRS0u7A3RmS
	gWsk5V/mFjfjEdhhYeZ68TCeRqRkQCd1mnpoWsHgOs+czIj6xW4w1kpcVrl7UfyFuX9yQ83ykQD
	aItTTkwtwcbvMMQnW84HAJjwLGw1qVvRXb5LL6QqBOc+mPuxEgpSP5mUT4LOJyvxUmT5E=
X-Google-Smtp-Source: AGHT+IGfJ4jAXlLObO9K1jZrI9GL4j1ShW+cz6w0jRuiMGIO7nChKGotXnQd9n+7p18z0F+1mc9sjrYcAIjZ/Fq9Fw==
X-Received: from zhangkelvin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2bb0])
 (user=zhangkelvin job=sendgmr) by 2002:a17:902:8f87:b0:205:58ee:1567 with
 SMTP id d9443c01a7336-20be17deed4mr6805ad.0.1727890996180; Wed, 02 Oct 2024
 10:43:16 -0700 (PDT)
Date: Wed,  2 Oct 2024 10:43:08 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241002174308.2585690-1-zhangkelvin@google.com>
Subject: [PATCH v1] Use pthread_kill instead of pthread_cancel for compatibility
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

pthread_kill is supported on more platforms. For example, android's
bionic libc does not have pthread_cancel. Since pthread_setcancelstate()
is not used in erofs-utils workqueue code, pthread_cancel has identical
behavior to pthread_kill, this switch should be safe.

Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 lib/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/workqueue.c b/lib/workqueue.c
index 47cec9b..3b63463 100644
--- a/lib/workqueue.c
+++ b/lib/workqueue.c
@@ -69,7 +69,7 @@ int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
 		ret = pthread_create(&wq->workers[i], NULL, worker_thread, wq);
 		if (ret) {
 			while (i)
-				pthread_cancel(wq->workers[--i]);
+				pthread_kill(wq->workers[--i]);
 			free(wq->workers);
 			return ret;
 		}
-- 
2.46.1.824.gd892dcdcdd-goog


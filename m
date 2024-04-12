Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136CE8A38AC
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Apr 2024 00:51:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1712962288;
	bh=4K0HHXCEWQYBPT7Bs/9NkhDTdgpcEExT1B9a2j0j5vA=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=eJAisEATRl4heNM6VjekEwOkQAW0E37f8iDf3RlhVPwZnRuJnYOFzXBk46tv/3t+3
	 tb4lAIF24CVN/lxrDIqcGXb0hlKx9Vr0YnVWdA8XN5Dew3FOtof4zLmfgLgQ8Ttl6i
	 QfuApHluk38XbcExsAbiIrjdFqKE39fx3q7xII//7pHodYPrdDWBRMinULlKfzrRul
	 cwsL6tnkirUUQTzIs860KkmkZU3ii9YAUqL12OFTgOnjnUjZc+TEJvjTAbrWsa724D
	 LlKaCUZcdrN+vDCHLkPai4TyLyLUWSfQvdJMQhkrBvVV/2lEQe31thUkFr/4Bwdblq
	 oBkJMHrd6AwSQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VGWyS2VqRz3dWK
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Apr 2024 08:51:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=JJzgF9Kq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::1149; helo=mail-yw1-x1149.google.com; envelope-from=34bozzgckc_qzdwrwhackkcha.ykihejqt-ankboheopo.kvhwxo.knc@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VGWyH18zbz3cCb
	for <linux-erofs@lists.ozlabs.org>; Sat, 13 Apr 2024 08:51:17 +1000 (AEST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-60cd041665bso25002497b3.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 12 Apr 2024 15:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712962273; x=1713567073;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4K0HHXCEWQYBPT7Bs/9NkhDTdgpcEExT1B9a2j0j5vA=;
        b=xPOn+5BIxQgpe1tZDmMFJ1N7DpKaGPWatDIn8ZrGNTePwHspgywEO/otUqPjjscvmZ
         J9/YLty5UiGXrpCU9qNjpEvrVoE5Ej2VqZR9xEbRd24LoIClQ3gf81uH5aALESs7kdYh
         RJBWZnpxbh1W7kMV61Z+caWmZB244NqOmVgTO7vfgN9sGEXIQzlkRBmNJC3nO2zPx+/8
         VohrRlnFLTD+hCqKaR7dNALpxLmhLEcDmQE+ckUUwloatjvK2ojbMa3ibdrpSBLVy5RH
         zN6YF49vGUjoYd0ZEz9FF/RZtYomeQg1ZIi3csmzjHPcNWSMrp3TZiwfssfxrrkGAGv5
         gF8w==
X-Gm-Message-State: AOJu0Yy+5IEQy1+wgSi2MP6TxMV/97BTb+ruy4Iqe9Q0DWPt1aANU8pi
	i+PBfEwUvOk7l9/bZoy9BZhQw+3rpa2wCmgCoI3sqo9IGI8JWov/O/myNDvQyBfDiMzPTMDROuJ
	M5MjYiYFKUzg3KWX2JsdKn6bEUS6/RlGDKh5efc3FZMcqdJ0n+jDhCXKk/8lpTEa9dWtISErMZI
	VS1T2V0zZwX5P1hsrcvClg1sYi8oq+Jmp+lVBWjEqK56oEFQ==
X-Google-Smtp-Source: AGHT+IF+V5XZKPXK7POluVcZdDNFCNebV98l+hZY5UsIziQIT4tf1ttKpadColzDrrnbShYxRjuPKN20Gv6A
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:da98:702b:8271:6b99])
 (user=dhavale job=sendgmr) by 2002:a0d:eb03:0:b0:615:102e:7d3b with SMTP id
 u3-20020a0deb03000000b00615102e7d3bmr1017064ywe.1.1712962273258; Fri, 12 Apr
 2024 15:51:13 -0700 (PDT)
Date: Fri, 12 Apr 2024 15:51:07 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240412225107.1240188-1-dhavale@google.com>
Subject: [PATCH v1] erofs-utils: dump: print filesystem blocksize
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

mkfs.erofs supports creating filesystem images with different
blocksizes. Add filesystem blocksize in super block dump so
its easier to inspect the filesystem.

The filed is added at last, so the output now looks like:

Filesystem magic number:                      0xE0F5E1E2
Filesystem blocks:                            21
Filesystem inode metadata start block:        0
Filesystem shared xattr metadata start block: 0
Filesystem root nid:                          36
Filesystem lz4_max_distance:                  65535
Filesystem sb_extslots:                       0
Filesystem inode count:                       10
Filesystem created:                           Fri Apr 12 15:43:40 2024
Filesystem features:                          sb_csum mtime 0padding
Filesystem UUID:                              a84a2acc-08d8-4b72-8b8c-b811a815fa07
Filesystem blocksize:                         65536

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 dump/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dump/main.c b/dump/main.c
index a89fc6b..947a5a4 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -669,6 +669,8 @@ static void erofsdump_show_superblock(void)
 	erofs_uuid_unparse_lower(sbi.uuid, uuid_str);
 	fprintf(stdout, "\nFilesystem UUID:                              %s\n",
 			uuid_str);
+	fprintf(stdout, "Filesystem blocksize:                         %llu\n",
+			erofs_blksiz(&sbi) | 0ULL);
 }
 
 int main(int argc, char **argv)
-- 
2.44.0.683.g7961c838ac-goog


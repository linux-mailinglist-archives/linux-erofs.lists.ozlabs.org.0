Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C39C95C398
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 05:05:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WqlM44kVTz2ykx
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 13:05:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724382351;
	cv=none; b=UfqxHqBAEoEgg8IJzZzSrYbYAYFtrGR3Fy6P03o50ugMI67ugrk9nYXVO9xfTn2b1H2QWykiY5rBw9HacWWZtnk9Jc/KNigVq5SE2guIJzfhcy8ezMHc8S05wq3Y/KVgBKW+bb3XEMzt8HWA4tXZadsiW85FFAY/APcVonFRbnBbvpXc52W7VIOAIGPYMgpIDh0oObUDdT5v30j6AC/KO8gcmyR2hzflvG5vYCKeLozse2FXXIPSe1h6wXjs93uHEBlPpMPhzkFLiVnPKE4jmT4HFQV7HKUrUa5mWB0lFowmkbDPVZWSVif7reVBItny2x0pbBRRFfvxR5hNkV/img==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724382351; c=relaxed/relaxed;
	bh=Pq0C1aRzAHoVhXyS4kaMh7Wg4xyGpeAa9UnKZXVrjAA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Google-Smtp-Source:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding; b=MXBh5aiiPj/EFQMb8es8za/fRq43CAppmy1x3muYz503z/TRYWdQzKwrIU1lNagcBmDxLS07MgeX4hKqtCxMWFAJQA7/IQbB/v7CpmLMPiQMefKMVEnX58Lr3xORbacsGkhn5kGjST0juqSWY+NDPnU3i/V+nqhOyhSkjNij6RrGh/q490EjmcpJwB/BrzAzVOc/5K3x0KIkQTwkfJKbMVihSybT5ghrfoFcDwPJyy1ULnDZbVuKshUyRnzJwSmPTPwmMpgzXsBAq78Nh74RNe/B31HcPpJrvYvE+lCm09GJ+jp2Vq3W0w286cG6H6iHiQx+SGeTqOhhc1TcOaBrKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=m9MfPOYm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=jinbaoliu365@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=m9MfPOYm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=jinbaoliu365@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WqlM22lvgz2yLP
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Aug 2024 13:05:48 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2d3b595c18dso1936150a91.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 22 Aug 2024 20:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724382344; x=1724987144; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pq0C1aRzAHoVhXyS4kaMh7Wg4xyGpeAa9UnKZXVrjAA=;
        b=m9MfPOYmP0HMdHHwHawo5qBoKOc7rk6Eub3Asr/UBGNecQ3W+quRHIhvQqCaVQfCyr
         1Y4N+GHv+VxDCBLc6cxTLVrVNTukmZ9TpG16JgwYDt9WQfHhPgo+S1Or5M0lE+rjakp2
         eZKL6OTynEet4i5BbQ+vkbPPVyqoGxhffozAeqjdvFKx842xVaI7jGEV49f/hHmyEitG
         HqzTP9khNDWDrtCMfEJ7nY8DNdZL3za5qqb5pVmgysIGDJHXoqbnAyL68xtxqOUGKfcK
         UKZA/eOBNZqs0bIW9WCySos9rlatbYBk7KSDnmvxw1Br3aLcGEJUVNn29+nALmHIoOp+
         6Kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724382344; x=1724987144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pq0C1aRzAHoVhXyS4kaMh7Wg4xyGpeAa9UnKZXVrjAA=;
        b=XXkuT/5IX/y9Atl9VeIboQ1acdUjrp65mjIPZmqt7+6PjoweqlTI06VxSoga9CybGz
         0NENWBDMIhZlEB/Qq8UftzwZGGf2/F7Q15rx1yAqoV/cu2OmiozgM3WwlcSSdKLDFRm5
         MRTZ87Oxc+pr0InSd6uFFnfSfOiYN5JIqRhhJyOC2VcVUslSKYcmBR3WHuBPbGtTtGPV
         4TkpY0Cwf+mZEDYUlMCoXAP+Ynex757cu4u9GInZbDAxrdCBFuPCna3EuurhZ/YTN1ng
         pyDndFb0+eM56+/uGLyF7bdFD0VF+kSxdYPBz+8gnBrkOKFawbAQF4CAlLFa0kXUX7bS
         UbvA==
X-Forwarded-Encrypted: i=1; AJvYcCUmQEiz7xDklA7uD9Hw8ZPIfgUORB9zZL0vY/oceIAheVq/9lKe0hLjoOukp931Q9KtuY7HT7En6EBCIw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxVj6nzuNO2IAVicC1Ze5TXnX0pz0EZqo7yzU/CeqkETeA0RA/1
	kDgh3zM9HAO81vush4Vp4qiAhPMMUoPhb5rqn68xfLQbu4okYYlv
X-Google-Smtp-Source: AGHT+IHRxxjWzMo/gQ86LcVvFpreUA+pLbsL7cJKw/E5UqRrCouKYM+QHAsdGLolQuq5mhtnBzgT6w==
X-Received: by 2002:a17:90b:188a:b0:2cf:dd3c:9b0d with SMTP id 98e67ed59e1d1-2d60a8cb8afmr7527855a91.2.1724382343787;
        Thu, 22 Aug 2024 20:05:43 -0700 (PDT)
Received: from mi.mioffice.cn ([2408:8607:1b00:8:8eec:4bff:fe94:a95d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d61391fe09sm2756114a91.19.2024.08.22.20.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 20:05:43 -0700 (PDT)
From: liujinbao1 <jinbaoliu365@gmail.com>
To: xiang@kernel.org
Subject: [PATCH] erofs: [PATCH v2] Prevent entering an infinite loop when i is 0
Date: Fri, 23 Aug 2024 11:05:25 +0800
Message-Id: <20240823030525.4081970-1-jinbaoliu365@gmail.com>
X-Mailer: git-send-email 2.25.1
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
Cc: mazhenhua@xiaomi.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, liujinbao1 <liujinbao1@xiaomi.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: liujinbao1 <liujinbao1@xiaomi.com>

When i=0 and err is not equal to 0,
the while(-1) loop will enter into an
infinite loop. This patch avoids this issue.

Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
---
 fs/erofs/decompressor.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

>Hi,
> 
>On 2024/8/22 14:27, liujinbao1 wrote:
>> From: liujinbao1 <liujinbao1@xiaomi.com>
>> 
>> When i=0 and err is not equal to 0,
>> the while(-1) loop will enter into an
>> infinite loop. This patch avoids this issue.
> 
>Missing your Signed-off-by here.
> 
>> ---
>>  fs/erofs/decompressor.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c index 
>> c2253b6a5416..1b2b8cc7911c 100644
>> --- a/fs/erofs/decompressor.c
>> +++ b/fs/erofs/decompressor.c
>> @@ -539,6 +539,8 @@ int __init z_erofs_init_decompressor(void)
>>      for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
>>              err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
>>              if (err) {
>> +                    if (!i)
>> +                            return err;
>>                      while (--i)
>>                              if (z_erofs_decomp[i])
>>                                      z_erofs_decomp[i]->exit();
> 
> 
>Thanks for catching this, how about the following diff (space-demaged).
> 
>If it looks good to you, could you please send another version?

>diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c index c2253b6a5416..c9b2bc1309d2 100644
>--- a/fs/erofs/decompressor.c
>+++ b/fs/erofs/decompressor.c
>@@ -534,18 +534,16 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
> 
> int __init z_erofs_init_decompressor(void)
> {
>-      int i, err;
>+      int i, err = 0;
> 
>        for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
>                err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
>-              if (err) {
>+              if (err && i)
>                        while (--i)
>                                if (z_erofs_decomp[i])
>                                        z_erofs_decomp[i]->exit();
>-                      return err;
+						break;
>-              }
>        }
>-      return 0;
>+      return err;
> }
>
missing break?
-- 
2.25.1


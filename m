Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4C964DBC9
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 13:58:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NXsjY2f2Lz3bf1
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 23:58:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eE7Ak6jK;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=tudor.ambarus@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eE7Ak6jK;
	dkim-atps=neutral
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NXsjT095tz3bNs
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Dec 2022 23:58:18 +1100 (AEDT)
Received: by mail-wm1-x32b.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so1750267wmb.5
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Dec 2022 04:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwYH3ujKbU1Du63Snr0pMmTST6dRtu8bysSgCO116YY=;
        b=eE7Ak6jKbiwDMWCYFiVygnx51rea3oQHieIRkFnhtDwwYfp/LsMkHbhtRPZVK6aISa
         uLwjgtpouvOwWtkNrZfMvShhUFEJfF1bv4xpC0hJv4MDH/fHgic41HvZGPa+7djniI9y
         ABoLhXEYzoqliCHvnq0Vy+Cy3hwFMZA2QKrOPMr7KaqF36XjL6pQ0Oqds4h7B1vbn8y0
         q2C/+aSFf52Ou1LZx+f/2gtGmo9RFVgDoYxGi8Y7pRj2F+PMeRV0TltprCgf6er47WSZ
         Gr5+2C8x+i0MxlhSjpYY5Snw0WyA8LIBddTl6h0N6t8JtnTU+lgUiZzAs7aVE0DEkQNu
         7QsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jwYH3ujKbU1Du63Snr0pMmTST6dRtu8bysSgCO116YY=;
        b=BfJWPrYbsknZoEjJtx6vRIPI2oC+Ze+993B/1EjHLMBMbrwnR0c5AiZ65x3RGDxrzE
         VazNEtM1LzDY9CH9fqd/xX1p7r8aP5XpeoZL8g21nXSezamp+DIdrf68Stu9l0XzJ7Qb
         7GIsWz18rak6cNfsg8hMkmY2P88mCA9A/3T7XkZNgEU89qGyUvnXU2zEnXjIJu0VYq5k
         fx3+J/TObPND2mtqiGXm4XjAWu3hJlbvip5R7ukCQ75NNT82a5jtOHik6iEzYLhaJ79b
         zMUIc4oJL73Lu+bRb9BgjDDcPcnjIir9NQtNupvCj74coplYEnzPHS02JX5xi7OzucUC
         zkTA==
X-Gm-Message-State: ANoB5pmlWZ9TN5egUVn6IGlgg5jbDGuZ2DKkeu3j+/3470ny7wPEkjY6
	zVUkYF6yHyNeGnLX2NBeZOl6t3BRyPGudySYr7U=
X-Google-Smtp-Source: AA0mqf4atkMpL65PjLsyFlVw5AF8QsgJ5VGJ8W+Ej+Ee5o9xomZOkrFcTbIpIpdByvvfcuZBFLcTNg==
X-Received: by 2002:a05:600c:3b84:b0:3cf:8762:22c2 with SMTP id n4-20020a05600c3b8400b003cf876222c2mr22284442wms.38.1671109092141;
        Thu, 15 Dec 2022 04:58:12 -0800 (PST)
Received: from [192.168.2.104] ([79.115.63.55])
        by smtp.gmail.com with ESMTPSA id q11-20020a7bce8b000000b003d23a3b783bsm5852026wmj.10.2022.12.15.04.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 04:58:11 -0800 (PST)
Message-ID: <17c7a0fb-9dc3-6197-358b-894aeb8ee662@linaro.org>
Date: Thu, 15 Dec 2022 14:58:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To: linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: BUG: unable to handle kernel paging request in
 z_erofs_decompress_queue
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: joneslee@google.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi, Gao, Chao, Yue, Jeffle, all,

Syzbot reported a bug at [1] that is reproducible in upstream kernel
since
   commit 47e4937a4a7c ("erofs: move erofs out of staging")

and up to (inclusively)
   commit 2bfab9c0edac ("erofs: record the longest decompressed size in 
this round")

The first commit that makes this bug go away is:
   commit 267f2492c8f7 ("erofs: introduce multi-reference pclusters 
(fully-referenced)")
Although, this commit looks like new support and not like an explicit
bug fix.

I'd like to fix the lts kernels. I'm happy to try any suggestions or do
some tests. Please let me know if the bug rings a bell.

Thanks,
ta

[1] 
https://syzkaller.appspot.com/bug?id=a9b56d324d0de9233ad80633826fac76836d792a

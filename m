Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C98739844
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jun 2023 09:39:39 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=jcZEYMma;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QmshR29dpz304l
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jun 2023 17:39:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=jcZEYMma;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=amergnat@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QmshJ0h0hz2yQB
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Jun 2023 17:39:24 +1000 (AEST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-988b75d8b28so521619466b.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 22 Jun 2023 00:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687419561; x=1690011561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kyBZGQlE3g+2vxed0mGUpWgi1BkyuNRNZMTHS+0UClg=;
        b=jcZEYMmaTGfXSJNIG6AiYj8K3pqSThJfZs0FMuItw9Dv4JqW0WLJzUjqbRfygZ68/Z
         tpJ3T8yshvY07weAiyJFAEJTqIZerhK7aJ+snvJ6VDjfdnzxIM35Z+0cM0eO96rrcgy8
         91PGYUb2r6b57MtyDqFXg0vddX6HnEfFZYlpLfi199bag1Kswfd3gRV4HrQl3VRPxTkd
         xsr/EWr/nG967uc1vdraW+eXvkmjloQFHlZdUn4BvjQq8i8OuDmhTR5pq+Oy7NUPWY/q
         E/qtm3UaXGm4DeWKenb38y70CufRY712AzbNgK8/Sx7PguEsLjdrC2+/som1eWDnyDvh
         7mkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687419561; x=1690011561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kyBZGQlE3g+2vxed0mGUpWgi1BkyuNRNZMTHS+0UClg=;
        b=EM+7kKCEkjrJ1ISTJWg9U4ifDfp/xEObskjVkwXeQN7zhgrynMgTbcJoeuQDErZra4
         /M1RVEKS8P6DdFNQahBoSu3kg7B7Sv4Um21hs+Arms2sTONS0RsgrVeTDExzT7NPZW/2
         UcDdG9CNEEdxsU6kDH9pVKKhIiB26JSo5Td5bBdlk6Rt5mxY6JztFwG+4SmOrVjPo9zJ
         RF2qd/7VdOB5nriXQ1vJhEFN8BL99UdEsLvcxmohZRdNoHPjAI9xTB1R/nGz8k5N02Oc
         I2jz/z5zEmaYAwoE3Y1wOmWu9V2fMCZ/TyFFE+u22vDy3/MHsL59MEtRNYOvv/Bx0ntt
         g1cw==
X-Gm-Message-State: AC+VfDw7cqNhXTCo4yXDDdTHJ5g26VziFFriqLvFQ2ZhOLwDNiMlRAHZ
	/bfsmxmM6egy0+stnzrkHTlDQXF8nTAXBudKS2w=
X-Google-Smtp-Source: ACHHUZ5W1Hm5W+HPcY3dmYtKyH5Zrzts4JCIeqr67/DMIHwyqq+LW+oLBpq8rwfO7/YWEuBleGLAsg==
X-Received: by 2002:a17:907:3f87:b0:984:bd75:6a3 with SMTP id hr7-20020a1709073f8700b00984bd7506a3mr14238689ejc.58.1687419561108;
        Thu, 22 Jun 2023 00:39:21 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id kk10-20020a170907766a00b00988a6421831sm4223077ejc.93.2023.06.22.00.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 00:39:20 -0700 (PDT)
Message-ID: <68cf749a-4248-1250-6e6e-713649ec8578@baylibre.com>
Date: Thu, 22 Jun 2023 09:39:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] erofs: Fix detection of atomic context
To: Sandeep Dhavale <dhavale@google.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20230621220848.3379029-1-dhavale@google.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230621220848.3379029-1-dhavale@google.com>
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
Cc: Will Shiu <Will.Shiu@mediatek.com>, kernel-team@android.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-erofs@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 22/06/2023 00:08, Sandeep Dhavale wrote:
> Current check for atomic context is not sufficient as
> z_erofs_decompressqueue_endio can be called under rcu lock
> from blk_mq_flush_plug_list(). See the stacktrace [1]
> 
> In such case we should hand off the decompression work for async
> processing rather than trying to do sync decompression in current
> context. Patch fixes the detection by checking for
> rcu_read_lock_any_held() and while at it use more appropriate
> !in_task() check than in_atomic().
> 
> Background: Historically erofs would always schedule a kworker for
> decompression which would incur the scheduling cost regardless of
> the context. But z_erofs_decompressqueue_endio() may not always
> be in atomic context and we could actually benefit from doing the
> decompression in z_erofs_decompressqueue_endio() if we are in
> thread context, for example when running with dm-verity.
> This optimization was later added in patch [2] which has shown
> improvement in performance benchmarks.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

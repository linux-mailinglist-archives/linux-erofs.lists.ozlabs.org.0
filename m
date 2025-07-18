Return-Path: <linux-erofs+bounces-677-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3A4B09C3C
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Jul 2025 09:19:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bk1PF5Gmxz2y8W;
	Fri, 18 Jul 2025 17:18:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752823137;
	cv=none; b=ZYGelxmSu6a2hJjkNfx+Hc/AS+rHt0l1+k6UeAlKKmOi1RyvrqkyAYmWxhAP30mAfGkmwIPTz/Gs9ajXMKT6QRtMEXrrjd05aGdb04VboO0moqFq724vkc98T8rihMXr25KVvWEpKtu/TLBqRnfUDUluJcqF1jDiLGSNzzZm4e6TwZ0kMaJ5mOxE/Q/5Rd8oaQbU58arrODm+ML9ioo1qndgtQHsgKBpSEW4qyolUZFVKP6O+wd8iSLGxDHmkiBeZcx6rcNfHKTvGMfztCQx4RsXkFA2X49NlrUrftxtC84AiYbBxXvUWzl1ooomsu2QHZEPzbKpmGPrzdmM/WWa7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752823137; c=relaxed/relaxed;
	bh=qOQtZWK71CEUFEPs+wC1xse+G2jR4a/7IF144JLOSlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTG4pzJVOUk0lWI+TOjq79lMxhIRHLoxosHEeqjciuHw1h36Dx7E6XolF6MXy940QyXA+BKoCzB5LcJyVC+q8JjwBpjtccDbnK041WIQR1voH7mdXVny19I6rTCViNTwZNGvMV9GA8lRshgtAsFFXPW4cn1tslJ1m7thL1i/raXIb+O5Sp5cuwvRDaWcJm2rLvMh3WzoA2yFWtzJqtlb73HTIxIqP2Ih+HPvUnGHkEw6R3fSGduk1m2TrALPL8N6JfBimZoKQQSQNFPGqi4yoaRp6ak8N07WLIFU63sN7koB+trWYq8wRsBUgVejlpH2TrJ3k696X7gMQJIIIQUOyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TCfw/0mE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TCfw/0mE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bk1PC6JClz2xtt
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Jul 2025 17:18:54 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752823130; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qOQtZWK71CEUFEPs+wC1xse+G2jR4a/7IF144JLOSlA=;
	b=TCfw/0mES4FL3RWHuHEHl8z0sRgJX/A1w+jAZtHGPLtInG61Vk3WLMFBPoVoWFum/Bx7AekYuZcspHbbDWBlUGGtMhIKHx8ssadJTwrdzHp2nO73+w8LoRbG3/yWYtZSiUejjq64vKR/CS/LG4VRozi4rscjXswY5u17v+W1Nfc=
Received: from 30.221.129.126(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjBLOCV_1752823129 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Jul 2025 15:18:49 +0800
Message-ID: <3134e79d-9f91-4af5-a15c-ab65509bef55@linux.alibaba.com>
Date: Fri, 18 Jul 2025 15:18:48 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] erofs: fix build error with
 CONFIG_EROFS_FS_ZIP_ACCEL=y
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250718033039.3609-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250718033039.3609-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/18 11:30, Bo Liu wrote:
> fix build err:
>   ld.lld: error: undefined symbol: crypto_req_done
>     referenced by decompressor_crypto.c
>         fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a
>     referenced by decompressor_crypto.c
>         fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a
> 
>   ld.lld: error: undefined symbol: crypto_acomp_decompress
>     referenced by decompressor_crypto.c
>         fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a
> 
>   ld.lld: error: undefined symbol: crypto_alloc_acomp
>     referenced by decompressor_crypto.c
>         fs/erofs/decompressor_crypto.o:(z_erofs_crypto_enable_engine) in archive vmlinux.a
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507161032.QholMPtn-lkp@intel.com/
> Fixes: b4a29efc5146 ("erofs: support DEFLATE decompression by using Intel QAT")
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

> 
> change since v3:
> - change Kconfg to select CRYPTO and CRYPTO_DEFLATE

These two lines should be moved under the line `----`, since
it shouldn't be part of the commit message, but I've removed
this time.

Thanks,
Gao Xiang


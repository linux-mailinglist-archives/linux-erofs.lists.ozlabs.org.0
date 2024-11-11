Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DDD9C3688
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 03:28:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xmtl56cz8z2yWK
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 13:28:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731292111;
	cv=none; b=k2qTQgDsDXY7iJnR6KLgIZlbJHhTsIhGNTUJdd1Xn3WHz1htiPV7rl2EWjoG7ZoJkafnOkI+xzR8pL0UhFtxfW4+5Ga5rIG4l85b3H2oEJeOckY7kxA3MkH6imatSw3ETtkWfmjA+L9zPc/Ynnda0F3F2sAZHiurGFcmlv2WuDHVFn1Dnucy9OMRTZhw5K7bMap85XUO3RYKouJnGnjwc3qx6LYFYgnZSHSWgf6Nqi92L+fBt6QO/f9EM3tbL4/jzbxNu8LyX1UrJYLXnanltfxWFgxPJy/FAneGvGnTv5VXo91zlKXVjHim4NovA0RGiNglS7ZYShps9yZ0ZDOENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731292111; c=relaxed/relaxed;
	bh=bANbxY9BmAz7NXQK5ofkVWL88hJguTT5ljf1WDdn6Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgzgjJDPpiHKKqkd4fzjkclZ50npO2RBW7Okdggu5vJLJg+DmqrSwmAXZDuiFY93LxJDF71GwXjelFdfJSdt2b9d5TZidNG7MvQqagOu64NEg0cJiG05GBdgepCq94sjD8kdCCXXXnoHVLa3QMVkI0xgw+/2IqFwiISQn/hCkIHPy4LTNvZKAaVfRoMiyqFcCbjOlTuKJ+qkH/lmMw9GV10/7JM76s86/f44aQf9UcC+KW2llfKJxFK0QfZxfp+QmO3dZqUjj4s7dZWHz9TIXP0QmMakMky3rOoNR23tBpF1Ku7+GOslpuIbbYgVl9MVO1Zak6S4OIPWgY89JuuZjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=T8mV35/b; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=T8mV35/b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xmtl26Vxqz2xGr
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Nov 2024 13:28:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731292106; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bANbxY9BmAz7NXQK5ofkVWL88hJguTT5ljf1WDdn6Ag=;
	b=T8mV35/bWwi+pXLKjBfmEGF6BjoYdN1fMbONpvcb8h9Ni8MzHrJEZ2Kc+k2FL3YniXFRWy31OU7rIw8ywu/CwxqxdX0yZAJ6ULALvjpaU7xMCyDp7Z2SvsUhPDyrQxLw3Q1MuYajl+GQzQOe7th+bUwyGaOSXGAxcN7QHUUtIz4=
Received: from 30.221.130.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJ447SW_1731292104 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 10:28:25 +0800
Message-ID: <0fa61236-e84b-4a3d-9804-612b33d166da@linux.alibaba.com>
Date: Mon, 11 Nov 2024 10:28:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: add sysfs node to control cached decompression
 strategy
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20241101124241.3090642-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241101124241.3090642-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chunhai,

On 2024/11/1 20:42, Chunhai Guo wrote:
> Add sysfs node to control cached decompression strategy, and all the
> cache will be cleaned up when the strategy is set to
> EROFS_ZIP_CACHE_DISABLED.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

I guess remount could also change the decompression strategy?
Or there are some other concern that remount is not usable
for your use cases?

Thanks,
Gao Xiang

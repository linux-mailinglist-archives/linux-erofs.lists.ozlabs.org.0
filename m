Return-Path: <linux-erofs+bounces-1618-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7A8CDEC2B
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Dec 2025 15:22:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dd79X4m43z2yFQ;
	Sat, 27 Dec 2025 01:22:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766758944;
	cv=none; b=KYMUujJXoOlFgj6V4zGfqJXcls9UOVGcN2Cb5VsLFU3k5Fly8XM0/maDt81eUpKAH58OJhxgzYd2kcKhRePVefum4NUxKiS813DOMSoLPtunxOGoxdNiZoKVOf66oHuJhr0moGVijdTiSp0zFKiLoJXoq8xmEJWUVCMK90A/ckZOwxGVK5HQXPNDHTh1jdKZi92jODYdh08BMZfhjwmkgeL+j9j8gsM3z4Joi8hjKVfmYKCh8uSsnEBUgYbuazbjxTBmhG4AbREE31oke9FqaTzTqL0pldab4iOhUE9ir6kW28tQHaBwCBVlgv7ZBT5zCHoZwWrD3qKtiOuYCTBoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766758944; c=relaxed/relaxed;
	bh=9xf2HFCC6Ziw68Fb8elQMRwG16Hpctrj/C6ytUD938o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHAD2ITfK3YcxSbYEiE6MJFFWwb7czKt2D3qZ2dmTZAU7VY73/P3sIZzwrJJLpS47KBsyUG2PQqPT/7LgaPH30vMr0doyDTWsI6Q0EXGoJ2j+VO20srsl2B6TkYQB/yzc2AOZl4QBKcvk0mi1KT/kYsJ29cM7FNMjTqMRUL9HVkRjP7QeRt5UdZtRJumuPSXG0E3A67HPpe9uIcKAJofRI9dw4PReap77naDOkYZ6BJd1H1VVs8+CiGyKXyFUfWiCH71waGoVSbUDZMYQfg78I49Mi4S+swWGKVE29K77sSJW9eNFLrFW6p7idR1jHO4kr7kIgjHAsJ1mPbWQKWcMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j4tb5Ztz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j4tb5Ztz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dd79T6ydwz2xg9
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 Dec 2025 01:22:20 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766758932; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9xf2HFCC6Ziw68Fb8elQMRwG16Hpctrj/C6ytUD938o=;
	b=j4tb5Ztzcn1/uId5tzxEvo3r1QVyacbIVGxkDX7K1yBQmYg3Hsnzzi2pIn2FnbMfJWO/mFhYSfm+//2SNmow431+cCx09bKKty+7EEgdgp4+lwR21jOlDVRWW0xdLw8TU2Byl2kaFlJvZlHQvEvaETDLZSV7F2WSkUedAwRvABQ=
Received: from 30.69.38.206(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvhnUlN_1766758923 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Dec 2025 22:22:11 +0800
Message-ID: <eef84292-a81f-4af0-83b4-c124932b973a@linux.alibaba.com>
Date: Fri, 26 Dec 2025 22:22:01 +0800
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
Subject: Re: [REGRESSION] erofs: new file-backed stacking limit breaks
 container overlay use case in 6.12.63
To: =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>,
 stable@vger.kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 xiang@kernel.org, Amir Goldstein <amir73il@gmail.com>,
 Christian Brauner <brauner@kernel.org>
References: <CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org




Hi Alekséi,

On 2025/12/26 20:17, Alekséi Naidénov wrote:
> Hello,
> 
> I am reporting a regression in the 6.12 stable series related to EROFS
> file-backed mounts.
> 
> After updating from Linux 6.12.62 to 6.12.63, a previously working setup
> using OSTree-backed composefs mounts as Podman rootfs no longer works.
> 
> The regression appears to be caused by the following commit:
> 
>    34447aeedbaea8f9aad3da5b07030a1c0e124639 ("erofs: limit the level of fs
> stacking for file-backed mounts")
>    (backport of upstream commit d53cd891f0e4311889349fff3a784dc552f814b9)
> 
> ## Setup description
> 
> We use OSTree to materialize filesystem trees, which are mounted via
> composefs (EROFS + overlayfs) as a read-only filesystem. This mounted
> composefs tree is then used as a Podman rootfs, with Podman mounting a
> writable overlayfs on top for each container.
> 
> This setup worked correctly on Linux 6.12.62 and earlier.

The following issue just tracks this:
https://github.com/coreos/fedora-coreos-tracker/issues/2087

I don't think more information is needed, but I really think the EROFS
commit is needed to avoid kernel stack overflow due to nested fses.

> 
> In short, the stacking looks like:
> 
>    EROFS (file-backed)
>      -> composefs (EROFS + overlayfs with ostree repo as datadir, read-only)
>          -> Podman rootfs overlays (RW upperdir)
> 
> There is no recursive or self-stacking of EROFS.
Yes, but there are two overlayfs + one file-backed EROFS already, and
it exceeds FILESYSTEM_MAX_STACK_DEPTH.

That is overlayfs refuses to mount the nested fses.

Thanks,
Gao Xiang


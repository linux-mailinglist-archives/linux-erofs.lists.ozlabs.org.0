Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9FB9F2DF0
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 11:13:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBbPn2kZCz2ywy
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 21:13:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734344028;
	cv=none; b=WHnlyDVjEIWpAgXUOdZW+EOWfo8LC4mRSHsnqniSba2R61VmO3KKDdaUrVuhT4VkB5L3vbO7JXjFdrACTzcvZYAlEFRRumQYWASKtt8G5u8RXI7erBorXm8W/lnWk/4NoMciv7ZvUig2wbVH0Vexir5TmPNQZzY/YT/fgBfD4HwPieiEDSJ4BhRlyLLpQz2ww6UHGUr9paNMaKBzpJPNDJ8waEpdZ6SNkJOtRztulCtCa/8j9191FQFVj5vc+Y7S4kTxNSuI6VRGLldZy0X4ismZHoAMBgs8RVISuSNgRDaf+9HQSFcp7d1ekW7Kzf09YjAGp0SY2DpfUbyK6QOSxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734344028; c=relaxed/relaxed;
	bh=V9ZM1VYLJhmWw0JXWXrNZw/asAR3qnp4u24wAg0Zo6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRcAH5f8dWG3kB2xZANqcFqnjVfdHFg/R9dQbTkZlG8CHrG/xryaUXGvywYqtL38NLdlGUH26FIleRJJjhhM+Hz9Y5m8mvtqt4GX12vaWC2Hcj8rH9wT1IdH2BfMSie7gL58U28MTxCim9+7SqlniyRUjRJgdT7ZNEemSQW0M+IiXq7Q76hF+yujwj1skAy5SG6B5zkaEzekPOeGpro7VQXY56UaWcpNAj9uIUZWtzy6J0h8tc5YHWihB7lQEC7CEORDC2GZOn/Y7ZEgDh82amvQ2rEXF5MwNrFZXf6IYKENjE192zc/mTkge4Ue0gpViuysFfTQCVM9zn1pwtz0gA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Vpmr8fDo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=akiyks@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Vpmr8fDo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=akiyks@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBbPl2gdYz2xks
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Dec 2024 21:13:47 +1100 (AEDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-728e1799d95so4570225b3a.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Dec 2024 02:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734344025; x=1734948825; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9ZM1VYLJhmWw0JXWXrNZw/asAR3qnp4u24wAg0Zo6s=;
        b=Vpmr8fDosz5uXJ/psio/iPwchjANLJKOiR2Sm4v89kMxJCdac/zIX9x5t6nKw/Bvjp
         bpeTsNFar5vEUQQh7PsWwyKX4NSd6APckvHAQJ1ewM2hSslBia1fRk/E9PjW8ullbPNb
         7emJ257UI0CSig88h8dr0OnVgIHLlTj1p6f6zYAMWyJ5DMwz37lOqoMcYiXD7lz9DdL5
         aFmISXC6lkllhwW5kEpwa7U7RNQjKhG1KwkHEIPTvb1rXqZ9aCJK/Eab6iVbA1LfLAqp
         UX24c6z2z8aTvpKeUaRZef8vD6P49aXpJFurwO5KHsCcrvB8cNwatWkRmuKiw00I4D/l
         CcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734344025; x=1734948825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9ZM1VYLJhmWw0JXWXrNZw/asAR3qnp4u24wAg0Zo6s=;
        b=TCxd0yIe4g1m9Jr8X52bp0grdmv32YGxRMsz+QV9bdui92wOhRUQHOFruCNvkXje4x
         WIwdEONuoKje/BvQjNlNPlfUJBd/evw53DQjUprlU18IfYd5DfpmcgbBkCgy/Vn1M6q4
         D3z+iz522ViAo/s5yKpjmxVc6paFfDTxSb3MJEqMaYbCQPIymbh2OQYAyV5EQgtLRt1V
         V6yZZnw/+dfBPxZxzIqYzXR987VvttYSyZP4a3YASpH50C/TqMiIK68wP5cfOtLDyamt
         6bIJB7/8PA907VbFaa0nW3aZSTO/SjmBfpuRN60NZBDy7blF662sNFY7SBxTmWWlfS5p
         HqZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2iRWnzTZg7veQvl7QV3wvkj/B5NkbVfKF2SxleFBl27i/rR2T+o/BldiOfL5ZKBnntPeIA40fs1JoLQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxMZfc4/7bjWC+B90tMCTirusEpeGzB5vuzo4nhm2Q176UNfKEl
	9X9zN47Jza+2Q6b2ZdLbTUa6Cn/lwg4QwcgDmnkETfcs9WHF8By1
X-Gm-Gg: ASbGncvez1I0HYPlwQCIRaN3atwKg0G3UnQZ/6H5E0bRn7C3Y2tOcvuNs6LZiTiTX/A
	842Il2YMqbvlJxKRfbVfU9/us+QVaUf7/Sh9mopxY7ThSMcmai68EmOypwHx9HWNY6K9e6FxrUN
	pvkInJIpjzs2CCh3dfxIfig1L8bNPSRWNhqlifYc+xrxy01VoGmiGCCOziHPly63ah8hzzuzaIk
	FAUmWP836NUDzntdEPW8z38lpZs37l6Y6ryb8C4Lx86LsJpuS38RweGtZL0or6Ul8aTGHxCsgUO
	c4XncKlz5YFTPhGtOOHlX5I=
X-Google-Smtp-Source: AGHT+IFq3zJyvoXfAV7XVBdCiDQC4vaO/7xLrUwixiOvu21RBmLw5wfgxXzoYw8zU6Yia4k+KM7puQ==
X-Received: by 2002:a05:6a20:4304:b0:1e1:bdae:e045 with SMTP id adf61e73a8af0-1e1dfd91980mr18130458637.23.1734344023005;
        Mon, 16 Dec 2024 02:13:43 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bce39csm4517791b3a.189.2024.12.16.02.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 02:13:42 -0800 (PST)
Message-ID: <843f5270-d715-4c98-b191-1c271eb418c5@gmail.com>
Date: Mon, 16 Dec 2024 19:13:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] netfs: Remove redundant use of smp_rmb()
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>
References: <20241213135013.2964079-1-dhowells@redhat.com>
 <20241213135013.2964079-7-dhowells@redhat.com>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20241213135013.2964079-7-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
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
Cc: linux-cifs@vger.kernel.org, Max Kellermann <max.kellermann@ionos.com>, v9fs@lists.linux.dev, Akira Yokosawa <akiyks@gmail.com>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, ceph-devel@vger.kernel.org, Zilin Guan <zilin@seu.edu.cn>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Trond Myklebust <trondmy@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

David Howells wrote:
> From: Zilin Guan <zilin@seu.edu.cn>
> 
> The function netfs_unbuffered_write_iter_locked() in
> fs/netfs/direct_write.c contains an unnecessary smp_rmb() call after
> wait_on_bit(). Since wait_on_bit() already incorporates a memory barrier
> that ensures the flag update is visible before the function returns, the
> smp_rmb() provides no additional benefit and incurs unnecessary overhead.
> 
> This patch removes the redundant barrier to simplify and optimize the code.
> 
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Akira Yokosawa <akiyks@gmail.com>

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

> cc: Jeff Layton <jlayton@kernel.org>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/20241207021952.2978530-1-zilin@seu.edu.cn/
> ---
>  fs/netfs/direct_write.c | 1 -
>  1 file changed, 1 deletion(-)
> 


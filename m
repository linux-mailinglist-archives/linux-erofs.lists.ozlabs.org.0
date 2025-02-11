Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BBCA30255
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2025 04:51:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YsSDW101Sz3bjM
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2025 14:51:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739245897;
	cv=none; b=mwaV9JS907Vke4IyIWaJ/Kdvml8HQlGYfWiQibwdiD4S3xqUtzcPeZmOtmrbPXcNZ4se2huy4wlSsAxHSuX50xFCvejDChKGflKchdLfgpimoVlrr2PZNaCVjBKtsSQJzx7WmCTA5QFZXtN84eL7sPoQR7uuV6y2mnwDOGINRUGCm2FSRonMTJZpmCxM880NLn9OxTYjFKip5fGn3aI+PxiKpkS1pPVXAwMbJ7+0rl9O8G+O4hsz5GoO9IVs7WCyM1RB7kKvjmMWPhTpYlpb6Hy1kMIUkIy+DBPHCoqN+QUBPG/Qd2AJQqplUVLGVhmyLqW70tTgmCE2ulDHftRJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739245897; c=relaxed/relaxed;
	bh=CTd6Vl7o8+ZAzWgQBfavyB4d/FR4e36IxwODWJTzF0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjDaqlIrEIUfx/2nuzEu00fZMf41mIUdxktrxxTh2fHGBtPw6cfAWEYGCb4zVAaGvw+Bcfd6YSCBl/Y0OAvI6MkEHq8dd17S2Xr6miA++a/KLog7PXDn7CqOGJpmrh/eCaJ4zXwDDW+tdOXKxGO8XaVO81WOiSy06IxgRle7jn75/Ca2gSieCAu8dxshCMnZvLkze2cSV78ag4szdShAT+tTVQoYC4R/NagkZkw7mOr5/IpYIU+qrHC3nYaiZYfed9y49MgdDsUl1oktTMXFIcc4clJy5e0UTPLDEizQc6uXlKMMRx87RcflF/VZ/O5taCG1vr3Pr6ogeFvPf2pacw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DEGCHIKi; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DEGCHIKi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YsSDR6sDqz2ydQ
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Feb 2025 14:51:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739245889; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CTd6Vl7o8+ZAzWgQBfavyB4d/FR4e36IxwODWJTzF0s=;
	b=DEGCHIKiyYmhuImei/HppVdbDi1j2Kqr1SLzfU7nSJQQ6p6gtjmE7xep0SiTczz2J6RsKu7YdK5Tuv53KFflnK/+96/jsOvBdBpTbqDxLrlxZcbTsDPmYpQKFDCGIN8B+ghLdX2d/1iAJ4Fc226Q1p3U7T/7tqORIdqWd/3EF+g=
Received: from 30.74.128.255(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPFRzq._1739245887 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Feb 2025 11:51:28 +0800
Message-ID: <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
Date: Tue, 11 Feb 2025 11:51:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Security vulnerabilities report to Das-U-Boot
To: Tom Rini <trini@konsulko.com>, Jonathan Bar Or <jonathanbaror@gmail.com>,
 Huang Jianan <jnhuang95@gmail.com>, Joao Marcos Costa
 <jmcosta944@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
References: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
 <20250207155048.GX1233568@bill-the-cat>
 <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
 <20250210164151.GN1233568@bill-the-cat>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250210164151.GN1233568@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Tom,

On 2025/2/11 00:41, Tom Rini wrote:
> On Fri, Feb 07, 2025 at 09:53:01AM -0800, Jonathan Bar Or wrote:
> 
>> Thank you.
>>
>> So, I'm attaching my findings in a md file - see attachment.
>> All of those could be avoided by using safe math, such as
>> __builtin_mul_overflow and __builtin_add_overflow, which are used in some
>> modules in Das-U-Boot.
>> There are many cases where seemingly unsafe addition and multiplication can
>> cause integer overflows, but not all are exploitable - I believe the ones I
>> report here are.
>>
>> Let me know your thoughts.
> 
> Adding in the eorfs and squashfs maintainers..
> 
>>
>> Best regards,
>>              Jonathan
>>
>> On Fri, Feb 7, 2025 at 7:50 AM Tom Rini <trini@konsulko.com> wrote:
>>
>>> On Thu, Feb 06, 2025 at 07:47:54PM -0800, Jonathan Bar Or wrote:
>>>
>>>> Dear U-boot maintainers,
>>>>
>>>> What is the best way of reporting security vulnerabilities (memory
>>>> corruption issues) to Das-U-Boot? Is there a PGP key I should be using?
>>>> I have 4 issues that I think are worth fixing (with very easy fixes).
>>>>
>>>> Best regards,
>>>>              Jonathan
>>>
>>> Hey. As per https://docs.u-boot.org/en/latest/develop/security.html
>>> please post them to the list in public. If you have possible solutions
>>> for them as well that's even better. Thanks!
>>>
>>> --
>>> Tom
>>>
> 
>> Filesystem-based Das-U-Boot issues.
>>
>> == erofs
>>
>> === Integer overflow leading to buffer overflow in symlink resolution
>> In file `fs.c`, when resolving symlinks, the function `erofs_off_t` gets an `erofs_inode` argument and performs a lookup on the symlink.
>> The function blindly trusts the `i_size` member of the input as such:
>>
>> ```c
>>      size_t len = vi->i_size;
>> 	char *target;
>> 	int err;
>>
>> 	target = malloc(len + 1);
>> 	if (!target)
>> 		return -ENOMEM;
>> 	target[len] = '\0';
>>
>> 	err = erofs_pread(vi, target, len, 0);
>> 	if (err)
>> 		goto err_out;
>> ```
>>
>> The `erofs_inode` structure's `i_size` member is defined with the type `erofs_off_t` (which is a 64-bit unsigned integer).
>> Thereofre, if supplied as 0xFFFFFFFFFFFFFFFF, the `len + 1` input to `malloc` would overflow to 0, allocating a chunk with 0.
>> That chunk (saved in `target`) is later written with `erofs_pread`, overriding the chunk with partial data controlled by an attacker.
>> Therefore, we will have a heap buffer overflow due to an integer overflow in `len` calculation.

Yeah, it's a corner case, I will try to address it later.

Thanks,
Gao Xiang

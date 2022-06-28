Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFC355E3B9
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 15:37:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXQd10pQjz3dsW
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 23:37:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ebZuBQlc;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f31; helo=mail-qv1-xf31.google.com; envelope-from=seanga2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ebZuBQlc;
	dkim-atps=neutral
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LXQcw3sRDz2xn8
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Jun 2022 23:37:19 +1000 (AEST)
Received: by mail-qv1-xf31.google.com with SMTP id p31so19943019qvp.5
        for <linux-erofs@lists.ozlabs.org>; Tue, 28 Jun 2022 06:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GTcKrabJVodGYTpD+K/ovzQ3VaeHrjTTo6nOF+sb8Eo=;
        b=ebZuBQlcci6BeWZMKFwt7KVx0R1HSMJSoQ60bi5QTLPB0ESqY+2G16c8UO7wjMvg1x
         VfYPUIFB5WW7cVrgco2an2x6W0ncdM3X1kf5A7DwiWdSfUaxSD4ia3U3kxtpMsnVFms/
         7URbn8PwvQmGp1JUONT+OKhvj8F6QvRuk8IFpS65czyKRXGQBf+05w16FwVsSanseBlu
         ixK459PozYq8mJ+bUT91Ct1NXI+8/8pTx+iGbgvJdQiXnPmcOVpeqJg4Pyjd64pI00pt
         CYiMWyxCYMN4xmtYzBy6x4Cwr+dlm1BA5j4HWhOy00HwkBgeYAXt4+U7dC8egbh54Hk6
         ZgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GTcKrabJVodGYTpD+K/ovzQ3VaeHrjTTo6nOF+sb8Eo=;
        b=323xSChMLkuhTx1OeFeWK+2WOaPrnCqAMVmXFI1apZKvsITi5+Qnnn3WJBupijjxLT
         rAO69TpVj4BA/t//YnKhmCSsxC6if+PYsK7HHjkMfsuXNLddIm4atMy4b+s7VV2xwW7Z
         9H7Ru7pxmCDVkKVNAtfZ+1/8XCu3wrt0Hfl8kUppNqByQBOAuGmPj0HlkX5NLcPkAE9x
         3me4hdOY8/+PcLnUz2eD/cZoW7nbR6P2fxq4EUNp4F+BB/6VMexV02jOZ5JbME3ULICS
         EYVpLLMka72ozr8qKRf6cbWLxVaSMMcYsCFhkgYnbM0sL6FgWoA6oAkU2xExTi3Lhhgw
         zJIA==
X-Gm-Message-State: AJIora+smhGRej05smA9oofHlRDHkuUrIEGDx2rjjb0yw7vZGY8rdPPR
	Rvht3YzBecxPWcsEOaS7Lis=
X-Google-Smtp-Source: AGRyM1sry+pf4jEIu97OD3MiI+23p9xHH3GUoqKD47kDQv6h3ccrLWnsTZfqcQbA9Y8+jSHJiBTVKQ==
X-Received: by 2002:ac8:5dd2:0:b0:304:ea09:4688 with SMTP id e18-20020ac85dd2000000b00304ea094688mr12936783qtx.526.1656423435923;
        Tue, 28 Jun 2022 06:37:15 -0700 (PDT)
Received: from [192.168.1.201] (pool-173-73-95-180.washdc.fios.verizon.net. [173.73.95.180])
        by smtp.gmail.com with ESMTPSA id t16-20020a37aa10000000b006a760640118sm11015695qke.27.2022.06.28.06.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 06:37:15 -0700 (PDT)
Subject: Re: [PATCH 0/8] u-boot: fs: add generic unaligned read handling
To: Qu Wenruo <wqu@suse.com>, u-boot@lists.denx.de
References: <cover.1656401086.git.wqu@suse.com>
From: Sean Anderson <seanga2@gmail.com>
Message-ID: <bb00b682-d1bf-0f72-df2a-fe5014a84ce6@gmail.com>
Date: Tue, 28 Jun 2022 09:37:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <cover.1656401086.git.wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: trini@konsulko.com, jnhuang95@gmail.com, joaomarcos.costa@bootlin.com, marek.behun@nic.cz, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 6/28/22 3:28 AM, Qu Wenruo wrote:
> [BACKGROUND]
> Unlike FUSE/Kernel which always pass aligned read range, U-boot fs code
> just pass the request range to underlying fses.
> 
> Under most case, this works fine, as U-boot only really needs to read
> the whole file (aka, 0 for both offset and len, len will be later
> determined using file size).
> 
> But if some advanced user/script wants to extract kernel/initramfs from
> combined image, we may need to do unaligned read in that case.
> 
> [ADVANTAGE]
> This patchset will handle unaligned read range in _fs_read():
> 
> - Get blocksize of the underlying fs
> 
> - Read the leading block contianing the unaligned range
>    The full block will be stored in a local buffer, then only copy
>    the bytes in the unaligned range into the destination buffer.
> 
>    If the first block covers the whole range, we just call it aday.
> 
> - Read the aligned range if there is any
> 
> - Read the tailing block containing the unaligned range
>    And copy the covered range into the destination.
> 
> [DISADVANTAGE]
> There are mainly two problems:
> 
> - Extra memory allocation for every _fs_read() call
>    For the leading and tailing block.
> 
> - Extra path resolving
>    All those supported fs will have to do extra path resolving up to 2
>    times (one for the leading block, one for the tailing block).
>    This may slow down the read.
> 
> [SUPPORTED FSES]
> 
> - Btrfs (manually tested*)
> - Ext4 (manually tested)
> - FAT (manually tested)
> - Erofs
> - sandboxfs
> - ubifs
> 
> *: Failed to get the test cases run, thus have to go sandbox mode, and
> attach an image with target fs, load the target file (with unaligned
> range) and compare the result using md5sum.
> 
> For EXT4/FAT, they may need extra cleanup, as their existing unaligned
> range handling is no longer needed anymore, cleaning them up should free
> more code lines than the added one.
> 
> Just not confident enough to modify them all by myself.
> 
> [UNSUPPORTED FSES]
> - Squashfs
>    They don't support non-zero offset, thus it can not handle the tailing
>    block reading.
>    Need extra help to add block aligned offset support.
> 
> - Semihostfs
>    It's using hardcoded trap to do system calls, not sure how it would
>    work for stat() call.

There are no alignment requirements for semihosted FSs. So you can pass in
an unaligned offset and it will work fine. This is because typically the
host will call read() and the host OS will do the aligning.

--Sean

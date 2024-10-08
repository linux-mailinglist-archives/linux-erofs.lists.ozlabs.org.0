Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C644994843
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 14:11:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNFGr5kwXz30gn
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 23:11:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728389459;
	cv=none; b=egEqtNgUXWiOxOZL8PrdRNBrzIwEtdFiufm7uP5bWSADZNzknaZhMEaWxm/M6zNneDymQu2++RQIseNfLQa2LGFXreyHhyFf/5+KMalJagdb1Cknpkk0ktStyAWM/oUxF10OKi7uA+/JBrWAStD4kJ2IDOCSMginMvH1DI0ahM4YJSW+ZYIBJVmU/Gx5yIRCASNZQt0KjQjM//mTXq0JsEDMVPijGf6gWaz97xRHd7xTDrqDPeV9kS7IViSiEKC481/TDf9IKG/DQ3addCAcQvBf3PtC4XaStQG3USIb7Y6wz8uXP+OXl4dID1bNFmDOKAuGneA4B5GXlSqgydFLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728389459; c=relaxed/relaxed;
	bh=YSHOWwL5PQ8Vjc/lzXai26oFbtfjaLjk7eVPoweFJR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3HfIz0CwotcS5Q7hVngFhH7qL1/z/rrTBxJ2WYIRtQksbCfexrE/+L3cxNx2N99fGj92TSVDf+f5r3dg4hWcdSJdyvZSzASAT97i4tuERdVSOv/ECRSGWt+BDZvcXfM/IZrsjwcG63MuOe2Xcu6Q2HC/6rUdrCLdxi6mG7n4KOOFfmvN0meB8aRrHSFE3DndgYwjnEw8RliBXykeBiv/0o0R8BuvIpkTMlUypkYSxKjga8vRj+GZcKW+9AeTOhlmw2PsTrWilIu/VxttvjiQyMKGD+m4SgG4rJUt1uNHJ0vAVCZ5d6kZJ330vPJCbohvqwyXjBhKfbOKHS6smu+4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FqLrQBhd; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FqLrQBhd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNFGl1LFbz2ym2
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 23:10:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728389447; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YSHOWwL5PQ8Vjc/lzXai26oFbtfjaLjk7eVPoweFJR4=;
	b=FqLrQBhdqNpku9GGqqTfMtQPgRt0sLFkZ3/mNl3JGKW3rNdN+oRf2JbYqBNOnRSrW3jQpatA/dJG3Yq0zOxv8/JSAzrYCkfZInAT7/ZWxjqva4HXOgWtuokkdV5mFb631MKrHB/BubDm8k4rRssmE0kR9eqTUflcGeSEBkZYuyk=
Received: from 172.20.10.8(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGek4fk_1728389443)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 20:10:45 +0800
Message-ID: <34cbdb0b-28f4-4408-83b1-198f55427b5c@linux.alibaba.com>
Date: Tue, 8 Oct 2024 20:10:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs/super.c: introduce get_tree_bdev_by_dev()
To: Christoph Hellwig <hch@infradead.org>
References: <20241008095606.990466-1-hsiangkao@linux.alibaba.com>
 <ZwUcT0qUp2DKOCS3@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZwUcT0qUp2DKOCS3@infradead.org>
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Allison Karlitskaya <allison.karlitskaya@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christoph,

On 2024/10/8 19:49, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 05:56:05PM +0800, Gao Xiang wrote:
>> As Allison reported [1], currently get_tree_bdev() will store
>> "Can't lookup blockdev" error message.  Although it makes sense for
>> pure bdev-based fses, this message may mislead users who try to use
>> EROFS file-backed mounts since get_tree_nodev() is used as a fallback
>> then.
>>
>> Add get_tree_bdev_by_dev() to specify a device number explicitly
>> instead of the hardcoded fc->source as mentioned in [2], there are
>> other benefits like:
>>    - Filesystems can have other ways to get a bdev-based sb
>>      in addition to the current hard-coded source path;
>>
>>    - Pseudo-filesystems can utilize this method to generate a
>>      filesystem from given device numbers too.
>>
>>    - Like get_tree_nodev(), it doesn't strictly tie to fc->source
>>      either.
> 
> Do you have concrete plans for any of those?  If so send pointers.

Thanks for your comment.

I don't have any pointer for now, just listing the potential use
cases for reference.

But the error message out of get_tree_bdev() is inflexible and
IMHO it's too coupled to `fc->source`.

> Otherwise just passing a quiet flag of some form feels like a much
> saner interface.

I'm fine with this way, but that will be a treewide change, I
will send out a version with a flag later.

Thanks,
Gao Xiang

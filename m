Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF4B6E3913
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Apr 2023 16:09:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PzsWS0Z5lz3cMb
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 00:09:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=r9iK4iHq;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=r9iK4iHq;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PzsWP27SDz3c6C
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 00:09:37 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7E5E860F18;
	Sun, 16 Apr 2023 14:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3882C433EF;
	Sun, 16 Apr 2023 14:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681654174;
	bh=CZbs+Oo/9VcJDCyqKQM4i7CGLF3MOsS+63CPee2VFD8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r9iK4iHqrEYnmRxTCYzjvjWyfqf6/YJCn23OAmmGUaC8wiP/KTVcspU91N+5/KbxI
	 QkRzM6kHMzvoklvhIGeQVtlXxWgVm4QqIwkpCyLqxJprFvzLtbMKpQdaOWYLuNXQxO
	 oUM2Do+YAlWdBFTsxocbz2Lta89uFZ34bK4Wb5FyHtMBnwvPICHKsSCP+JfN/fEZM1
	 h58cE/lATTODdp9qKr2xIqKqXPjTTrett1DmQxxrrrlfvqEBypLrSidmOT3FPBFzxd
	 +qskagLD13RxU1KizAl6WGK12X/HpFhlJ/dbQnKiPeWCv6IuszNTz7lTmerh5Hgm/I
	 6D/45z6NV+fMQ==
Message-ID: <87dc51ef-35d2-6ae9-6e56-667bbc04526c@kernel.org>
Date: Sun, 16 Apr 2023 22:09:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v6 2/2] erofs: set block size to the on-disk block size
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230313135309.75269-1-jefflexu@linux.alibaba.com>
 <20230313135309.75269-3-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230313135309.75269-3-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/3/13 21:53, Jingbo Xu wrote:
> Set the block size to that specified in on-disk superblock.
> 
> Also remove the hard constraint of PAGE_SIZE block size for the
> uncompressed device backend.  This constraint is temporarily remained
> for compressed device and fscache backend, as there is more work needed
> to handle the condition where the block size is not equal to PAGE_SIZE.
> 
> It is worth noting that the on-disk block size is read prior to
> erofs_superblock_csum_verify(), as the read block size is needed in the
> latter.
> 
> Besides, later we are going to make erofs refer to tar data blobs (which
> is 512-byte aligned) for OCI containers, where the block size is 512
> bytes.  In this case, the 512-byte block size may not be adequate for a
> directory to contain enough dirents.  To fix this, we are also going to
> introduce directory block size independent on the block size.
> 
> Due to we have already supported block size smaller than PAGE_SIZE now,
> disable all these images with such separated directory block size until
> we supported this feature later.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Reviewed-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FAF6E3911
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Apr 2023 16:08:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PzsV50TlJz3c6C
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 00:08:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VMkhug+k;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VMkhug+k;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PzsV02cr1z3c6C
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 00:08:24 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8503560DB6;
	Sun, 16 Apr 2023 14:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66491C433D2;
	Sun, 16 Apr 2023 14:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681654099;
	bh=ayfPSItOfFk4TQ7c63fW3LnrbPB2BuMo6DU7rxoTrCA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VMkhug+kVu/kyJxgTkqUl6yJ0sghB4L3Tk7zEkwGWH979coou288mUcnRivlBsp6i
	 mMkoPTbYGiO0Kz36IgkhCa5am9cPc40gChl3ohBN4UlW2A2eAtxteoU9tC/AggI0aK
	 Whr4upxppwsRicmZYe5W7Q9yzUZO7g7fnfsRR5MIpRNtgyM2crIpIKzYJnr3WGVVDI
	 eDZFVhFgMwyrxxe9yn5nzPabOfhHHDT6xUm4lz0IhBajHr9RmE0jvaqVb6kR2qfKkg
	 fWXyzj8utxdUgSrlVeoQ++oLEK1N/Ka2B/XYen16fxfUrzJVkVn2ayfgebxVsjcvDp
	 wAZavjkt0zQeQ==
Message-ID: <75010857-7766-8196-77d4-24bb688ccb5c@kernel.org>
Date: Sun, 16 Apr 2023 22:08:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v6 1/2] erofs: avoid hardcoded blocksize for subpage block
 support
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230313135309.75269-1-jefflexu@linux.alibaba.com>
 <20230313135309.75269-2-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230313135309.75269-2-jefflexu@linux.alibaba.com>
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
> As the first step of converting hardcoded blocksize to that specified in
> on-disk superblock, convert all call sites of hardcoded blocksize to
> sb->s_blocksize except for:
> 
> 1) use sbi->blkszbits instead of sb->s_blocksize in
> erofs_superblock_csum_verify() since sb->s_blocksize has not been
> updated with the on-disk blocksize yet when the function is called.
> 
> 2) use inode->i_blkbits instead of sb->s_blocksize in erofs_bread(),
> since the inode operated on may be an anonymous inode in fscache mode.
> Currently the anonymous inode is allocated from an anonymous mount
> maintained in erofs, while in the near future we may allocate anonymous
> inodes from a generic API directly and thus have no access to the
> anonymous inode's i_sb.  Thus we keep the block size in i_blkbits for
> anonymous inodes in fscache mode.
> 
> Be noted that this patch only gets rid of the hardcoded blocksize, in
> preparation for actually setting the on-disk block size in the following
> patch.  The hard limit of constraining the block size to PAGE_SIZE still
> exists until the next patch.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Reviewed-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

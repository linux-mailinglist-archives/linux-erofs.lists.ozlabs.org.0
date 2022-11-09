Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FA6622D23
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Nov 2022 15:05:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N6mvD4JdGz3cJL
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Nov 2022 01:05:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gt3MezR3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gt3MezR3;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N6mv760RKz2xKN
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Nov 2022 01:05:07 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C0BAD61ACE;
	Wed,  9 Nov 2022 14:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5197CC433C1;
	Wed,  9 Nov 2022 14:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668002704;
	bh=vBn2fEDaoudFrydSipyR3+m1csUoY+FwJ8d+5n10xrk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gt3MezR3O/dgVapaEtq3XhBVIYbTqbcQzGASlN8KHyDpfEcPuyiVoZ31qShh1q0PU
	 rLtY7LARe67GqeO7wv7RtqxCS17GiFOIBL65mRw2t4Swzn49MgrcLv6m5e3HaSmEma
	 5WyDZR1ZFbVnHea3eMFe5VzA4KDUFWoJt1V1tdOhyFT74+nR3GTphCVccEwMAGX6XY
	 PqYb6R8J67afJL1gKAtFtXN/OkKgLQYtuADVDLPSBsKIQWImD44i4UuOhFpNZcAARR
	 9KbzA+wiS1c78IlXgAzjf0A+CaZ7WesM6kIvZX7WgkApuNBqcV455x24VtbhgGa9EV
	 lram04sAqy7aw==
Message-ID: <85ec05a7-b8bc-3f1a-ee61-01f505a0c0ad@kernel.org>
Date: Wed, 9 Nov 2022 22:04:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] erofs: fix use-after-free of fsid and domain_id string
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org, zhujia.zj@bytedance.com
References: <20221021023153.1330-1-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221021023153.1330-1-jefflexu@linux.alibaba.com>
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
Cc: linux-fsdevel@vger.kernel.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/10/21 10:31, Jingbo Xu wrote:
> When erofs instance is remounted with fsid or domain_id mount option
> specified, the original fsid and domain_id string pointer in sbi->opt
> is directly overridden with the fsid and domain_id string in the new
> fs_context, without freeing the original fsid and domain_id string.
> What's worse, when the new fsid and domain_id string is transferred to
> sbi, they are not reset to NULL in fs_context, and thus they are freed
> when remount finishes, while sbi is still referring to these strings.
> 
> Reconfiguration for fsid and domain_id seems unusual. Thus clarify this
> restriction explicitly and dump a warning when users are attempting to
> do this.
> 
> Besides, to fix the use-after-free issue, move fsid and domain_id from
> erofs_mount_opts to outside.
> 
> Fixes: c6be2bd0a5dd ("erofs: register fscache volume")
> Fixes: 8b7adf1dff3d ("erofs: introduce fscache-based domain")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

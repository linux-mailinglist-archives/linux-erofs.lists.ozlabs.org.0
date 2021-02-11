Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2D13182F4
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Feb 2021 02:15:57 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dbdx72rbhzDskF
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Feb 2021 12:15:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RcEdLIJo; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dbdx03vqzzDwkH
 for <linux-erofs@lists.ozlabs.org>; Thu, 11 Feb 2021 12:15:48 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0117A6146D;
 Thu, 11 Feb 2021 01:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613006145;
 bh=hWpMFDvhdeaSaUSFOQZMqSuM/fCNtN3RQDyF51Ik2Dc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=RcEdLIJowKtFimfaXiZlA9uGx+iwXeZqdOTJJq49GeD1cRMy7b3yiwNdrOZrY8P5q
 c2wx4YG2HNgR4ri1SOm/ZUs6bcnMvErQpNXoT4rewuCYLddHrD53qJUJIqfZg0+aXD
 lzSUSe4lMh/RoFGXD6ccBbP1TECuWEbT7gfI74CXzG/iZbGBdDzzgK27yjei0AZDCs
 zj+rAjRYBQDpHadwaeTtS1EKA36IKyEQLdi1UKOUAg+z9Dgs+GrtVCxTf2PtNCP21W
 igquIYRXEp782mWQgZAQrxdXJtCHhiqLjYoty+LRdCog2vRmP7NdEYQg6qMdDaN/0a
 yGrmf32m30k3A==
Subject: Re: [PATCH] erofs: fix shift-out-of-bounds of blkszbits
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
References: <20210120013016.14071-1-hsiangkao.ref@aol.com>
 <20210120013016.14071-1-hsiangkao@aol.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <b950de55-e086-c7f8-0303-6033c589619a@kernel.org>
Date: Thu, 11 Feb 2021 09:15:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210120013016.14071-1-hsiangkao@aol.com>
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
Cc: syzbot+c68f467cd7c45860e8d4@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/1/20 9:30, Gao Xiang via Linux-erofs wrote:
> From: Gao Xiang <hsiangkao@redhat.com>
> 
> syzbot generated a crafted bitszbits which can be shifted
> out-of-bounds[1]. So directly print unsupported blkszbits
> instead of blksize.
> 
> [1] https://lore.kernel.org/r/000000000000c72ddd05b9444d2f@google.com
> Reported-by: syzbot+c68f467cd7c45860e8d4@syzkaller.appspotmail.com
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

Sorry, I missed this patch.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

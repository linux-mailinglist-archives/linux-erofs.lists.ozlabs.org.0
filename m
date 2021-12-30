Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0999B481932
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Dec 2021 05:01:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JPZMx6szfz305c
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Dec 2021 15:01:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tBKOG+5Z;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=tBKOG+5Z; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JPZMq5lZYz2yP9
 for <linux-erofs@lists.ozlabs.org>; Thu, 30 Dec 2021 15:01:43 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BED80615DA;
 Thu, 30 Dec 2021 04:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8C9C36AEB;
 Thu, 30 Dec 2021 04:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640836901;
 bh=FERXy+wCBsLySbQi2xNjJ07L5Ynq/sY5UAciAdWIWRA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tBKOG+5ZCgE5hHDbMhCyYe+JgSMlEOSEjl3ActVRovdBTIttPiKrZHgvf+6xfHzBS
 l85Tl7i4kuzhhoHb7JKHWq87fZhim2gxaBtshYaMfRuxcytZ+HJpcQGYKmzUG4dr+s
 qQTXIsiwl852WEQS+XyHirQ+4mtko+RcnA2rdpo+ywMkGPLDTt6kexkuNRifLXguBV
 mPb0Rkhfr83mLms1UfpZX6Zv3o+BJ5OSMQ7RI1HxJyjLv9KzV/TQCiLpXFGc4Snmq4
 i+foA4JAv8+GddUZSQHZVbwqrZgOFbETdhySWyOylu7iLwM1VelzXKZ7BxniyGGNFo
 P2yWe1UWpADfQ==
Message-ID: <331dda35-b5cc-86c9-83ff-b30b383531b6@kernel.org>
Date: Thu, 30 Dec 2021 12:01:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 5/5] erofs: add on-disk compressed tail-packing inline
 support
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20211228054604.114518-1-hsiangkao@linux.alibaba.com>
 <20211228054604.114518-6-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211228054604.114518-6-hsiangkao@linux.alibaba.com>
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
Cc: Yue Hu <huyue2@yulong.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/12/28 13:46, Gao Xiang wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Introduces erofs compressed tail-packing inline support.
> 
> This approach adds a new field called `h_idata_size' in the
> per-file compression header to indicate the encoded size of
> each tail-packing pcluster.
> 
> At runtime, it will find the start logical offset of the tail
> pcluster when initializing per-inode zmap and record such
> extent (headlcn, idataoff) information to the in-memory inode.
> Therefore, follow-on requests can directly recognize if one
> pcluster is a tail-packing inline pcluster or not.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

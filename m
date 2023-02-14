Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 983A6696755
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Feb 2023 15:51:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PGPKZ3f8Cz3cJn
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Feb 2023 01:51:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tLl68cg+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tLl68cg+;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PGPKW0fkPz3c6m
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Feb 2023 01:51:11 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3335A616CB;
	Tue, 14 Feb 2023 14:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC91C433D2;
	Tue, 14 Feb 2023 14:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676386268;
	bh=Y94r2TscOLy/MxOKf0gUOIvXNThFe6Bsl7fFc+iHFvk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tLl68cg+GazPQfCYc3P5523RwC/doMFNOw1Jh2Z1/W4otRjhNahqRO6rQRAw6BDBa
	 hfEsdRRhVBwqiq8Y5tn81QZV2C0OtjPkIuDUV95csz16oq+YrlzvU/h9l6yqbM7oFr
	 0t1y67CZfucVCdwWxLYJLf7WJUm0+C7QhVZQw6vXyuNtNuHkd4L4pSSfObZ720QOuP
	 tOb3PK4+Ony3udDANK99VMJ7PIwEnG0vw2r+2TJyQ29BCizZIKYRewHRfdGXJfuwIN
	 6CO0wIeB6gGVHRZP+6ci5EIZqg0aqZTIBwdLNfO0Ths+hLu16ohm31bUblw2NoZo2S
	 H9QEPYy4NgbbA==
Message-ID: <109243cc-6ebb-d76d-104c-6576b94fc4af@kernel.org>
Date: Tue, 14 Feb 2023 22:51:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/2] erofs: remove unused EROFS_GET_BLOCKS_RAW flag
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
References: <20230209024825.17335-1-jefflexu@linux.alibaba.com>
 <20230209024825.17335-2-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230209024825.17335-2-jefflexu@linux.alibaba.com>
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

On 2023/2/9 10:48, Jingbo Xu wrote:
> For erofs_map_blocks() and erofs_map_blocks_flatmode(), the flags
> argument is always EROFS_GET_BLOCKS_RAW.  Thus remove the unused flags
> parameter for these two functions.
> 
> Besides EROFS_GET_BLOCKS_RAW is originally introduced for reading
> compressed (raw) data for compressed files.  However it's never used
> actually and let's remove it now.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

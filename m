Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304166E391B
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Apr 2023 16:16:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pzsfj01R7z3cMb
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 00:15:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L/sqBDQq;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L/sqBDQq;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pzsfd4wBWz3c6C
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 00:15:53 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3DD2C60D54;
	Sun, 16 Apr 2023 14:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F050FC433EF;
	Sun, 16 Apr 2023 14:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681654547;
	bh=IJ/KLvgNXsd9AoIh2GNOX1lbUJteynHZL0yqKS/lun0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L/sqBDQqAkrUPyAnQJoIWII4VDnPxMLUSQQlOKcv+osZ065YJy23uc/J0Gox8zUb4
	 PGIwhClkBvY8TWbI+5oroRdZPEk8GUrlY9+nDeohWzvd85XvKfZXkQU6ns2ecyc2lj
	 lnD09ZHiHeD2MJoxk38XfNvVEPwCVoWEFXdr8sE3ulHHXa70NSWkqLCxcWrWBI3nQM
	 dBtw2L7YUHHiw5AQmqbZrY+mdHAYGeeQXKKVBp5zbpihfU+yXSjdOKqRBIEPCMs/kR
	 himMtOmaIYfSkOGPUbl58Zr4wckxdBHSDfoEb24pdhCc7gstMwHexkRtS3hfCZOANs
	 hBHGknVxUXdUA==
Message-ID: <a30999d4-bc1c-8b5b-d2b2-186c80bac4b6@kernel.org>
Date: Sun, 16 Apr 2023 22:15:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] erofs: tidy up EROFS on-disk naming
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230329054935.78763-1-hsiangkao@linux.alibaba.com>
 <20230331063149.25611-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230331063149.25611-1-hsiangkao@linux.alibaba.com>
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
Cc: LMKL <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/3/31 14:31, Gao Xiang wrote:
>   - Get rid of all "vle" (variable-length extents) expressions
>     since they only expand overall name lengths unnecessarily;
>   - Rename COMPRESSION_LEGACY to COMPRESSED_FULL;
>   - Move on-disk directory definitions ahead of compression;
>   - Drop unused extended attribute definitions;
>   - Move inode ondisk union `i_u` out as `union erofs_inode_i_u`.
> 
> No actual logical change.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


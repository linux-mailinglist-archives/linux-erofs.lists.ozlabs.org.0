Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F504D9731
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Mar 2022 10:09:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KHnfc2ZTZz30KB
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Mar 2022 20:09:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qYo81yqD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qYo81yqD; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KHnfX5mVdz2yjS
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Mar 2022 20:09:40 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C823EB811CC;
 Tue, 15 Mar 2022 09:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBADC340E8;
 Tue, 15 Mar 2022 09:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647335375;
 bh=qjtgoi5NGl4oJrj4hfKOe5E1NWLCN6cFlqZz4tr9NqY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qYo81yqDaPO1T4UlWcA5dYLBmQM2/DXS/eZUHLdheGu5fwRXEG9R5f1MkXgKrtH9y
 9j7LeTqAnkgHea+qJKudf5Zzl76nYCAMUwPZtKQi8/RYO251oG0+Mbp/bTDs+Q+lp5
 W/JWi3DgHgitbeL3ctURqEXZLbj4jsQVcpbwbG/mFxZIQio8+zzyfygi/WTz7seyiz
 7Ns98AvYXfQOn7TvuZ8LBptRX+8ysPVpeOgUY4ZfhwRMHlblqyhXBY7XjSdUru0/PO
 IQ7AExPzlzVUaFrp96zaM+6IUzSz9DR8B5c5k4Urhd7GTxU/hSsktahbyftKty7Je8
 uVIpswvdMynEw==
Message-ID: <419095e2-2167-ebd7-ed23-0d96ae8c095b@kernel.org>
Date: Tue, 15 Mar 2022 17:09:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/2] erofs: refine managed inode stuffs
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20220310182743.102365-1-hsiangkao@linux.alibaba.com>
 <20220310182743.102365-2-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220310182743.102365-2-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/3/11 2:27, Gao Xiang wrote:
> Set up the correct gfp mask and use it instead of hard coding.
> Also add comments about .invalidatepage() to show more details.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

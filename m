Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D19483DA8
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jan 2022 09:07:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JSlZp6Mgfz2ynj
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jan 2022 19:07:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=spSQe3Dn;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=spSQe3Dn; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JSlZl5hgzz2xDY
 for <linux-erofs@lists.ozlabs.org>; Tue,  4 Jan 2022 19:07:11 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D0E31612C2;
 Tue,  4 Jan 2022 08:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A7AC36AE9;
 Tue,  4 Jan 2022 08:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641283629;
 bh=tEIqXUPGXKezh7T3zqNrkDAki4hP2luXd7eY8IDlFqQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=spSQe3DntNAnVOisheBB/kIUxh/0TVCWMmUZLfv8OU3teA7uhApPzRIKCCBY/9vls
 6UHEONVwSkpm3G5Ol7d9diEh6eLp7SLYnJ73QnLvKsq5R5zIjLVu6pI5CumJY7XsjJ
 DaW0K1AxvwmXxRqPsN6PyqqAWUKPW7CDV/Fv8afpj0NxeBPMHwX0MmBHzAS/mXCJ/c
 HIule9t2Bs83RpUQm6SSQWkiCaZgbBq9TcO1e8ob2Q4FoWbiy90fL80+i06EXRvPXB
 YKpawanwUzdhsZN41wjEY9JysMv8XZVa4MEqAUsF0ysB4Au/5DmcR2lXRe/omEVYCD
 1eypsxDB86Kew==
Message-ID: <b3955e02-a467-9de3-cb41-d4f5b014791f@kernel.org>
Date: Tue, 4 Jan 2022 16:07:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 4/5] erofs: use meta buffers for xattr operations
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 Liu Bo <bo.liu@linux.alibaba.com>
References: <20220102040017.51352-1-hsiangkao@linux.alibaba.com>
 <20220102040017.51352-5-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220102040017.51352-5-hsiangkao@linux.alibaba.com>
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

On 2022/1/2 12:00, Gao Xiang wrote:
> Get rid of old erofs_get_meta_page() within xattr operations by
> using on-stack meta buffers in order to prepare subpage and folio
> features.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

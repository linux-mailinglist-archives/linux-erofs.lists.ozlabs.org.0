Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A255E4D5D39
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 09:24:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KFJqq3HGbz300B
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 19:24:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=d1Aofjpl;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=d1Aofjpl; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KFJqn0Lygz2xgb
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Mar 2022 19:24:05 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B5ACC61DF1;
 Fri, 11 Mar 2022 08:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7BCC340F3;
 Fri, 11 Mar 2022 08:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646987042;
 bh=vj6CfSHOXQ9Mtuetdyb8VmglTURJ+IW9CGO2ktkkhl8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=d1AofjplgR64OwNX0sGVbCWDiqMvUSM7NJ89M69UEG2NLGVRUV9X9TZ2C/IRfGAfB
 tcHFZwaD+OTW0B3/H3Av2jnM4eGYfJkfmul6AUiHRZUv7mmrmYMIZLwalBrq6wnpJJ
 x2PS1ktqRz4QWhD8e6r2j+acNGPq3vVnkyM0zdsUATMxijTImmWRB1nOPuWVhXOzUE
 LlUkXShM65Y7zJmZt9MaDb84sjlg3UG/onVKkn//ho/8iwvPHC53qiMRZKbxoI/xw6
 BIMOjpHtnUQsljmX57pIc0wz0TY4EG2UdfWDKMuEDbHp+FRFImiU21gmXG+LPp3PW/
 p2RqHm8iQ8rYA==
Message-ID: <2c4ed430-efc9-1328-b630-9b951f87a5b1@kernel.org>
Date: Fri, 11 Mar 2022 16:23:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] erofs: silence warnings related to impossible m_plen
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20220310173448.19962-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220310173448.19962-1-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, kernel test robot <lkp@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/3/11 1:34, Gao Xiang wrote:
> Dan reported two smatch warnings [1],
> .. warn: should '1 << lclusterbits' be a 64 bit type?
> .. warn: should 'm->compressedlcs << lclusterbits' be a 64 bit type?
> 
> In practice, m_plen cannot be more than 1MiB due to on-disk constraint
> for the compression mode, so we're always safe here.
> 
> In order to make static analyzers happy and don't report again,
> let's silence them instead.
> 
> [1] https://lore.kernel.org/r/202203091002.lJVzsX6e-lkp@intel.com
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

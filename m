Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DC3537023
	for <lists+linux-erofs@lfdr.de>; Sun, 29 May 2022 09:12:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L9qW85B2Wz3bkq
	for <lists+linux-erofs@lfdr.de>; Sun, 29 May 2022 17:12:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bD14cGnj;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bD14cGnj;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4L9qW16Fm8z2yWn
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 May 2022 17:12:45 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 60E12B8091D;
	Sun, 29 May 2022 07:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B688C385A9;
	Sun, 29 May 2022 07:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653808361;
	bh=jSg2i6Fv64cazvRJ/QybIFUdNSfT2GdaxWk7bR2XZh4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bD14cGnjEKnU6GfaB/zn6Us2qcXxd99vJGlGJep5JZ5lvZch300Z+u2M9bLGgdzop
	 Z9dBgiCbgfwivFAktAOTZIxQ0W/+IRlnWZ9LxUcYQ9NL8Op3P9c7mJScb4lTv7INTo
	 flD+B3JAXzkvwAjN1VRmm2ZfhqrDaK8dhkvPX5Ieuia9Yk1qMSkaLJVtv1Qz3Ya0YC
	 zaZSznTWlMyeNgzuFRfPcXfCOeoEzJZEyAlqKN0uN8CIjbXhILYceiWhBpB+SMprle
	 5SEvGdEgtjOnvjDgSa20N0K4uMUpLF89dezGQi9xt4ufhzXQaHjx98ssFrcZhO0eCq
	 amKFhqWdr4buA==
Message-ID: <bda6125a-2141-dcfe-d275-720ebae4c7bd@kernel.org>
Date: Sun, 29 May 2022 15:12:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] erofs: update documentation
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20220527070133.77962-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220527070133.77962-1-hsiangkao@linux.alibaba.com>
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

On 2022/5/27 15:01, Gao Xiang wrote:
>   - refine the filesystem overview for better description of recent
>     new features like FSDAX or Fscache;
> 
>   - add the new `fsid' mount option;
> 
>   - fix some typos.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

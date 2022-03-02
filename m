Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBF14C9B6A
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Mar 2022 03:50:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K7drR0MnNz3bd9
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Mar 2022 13:49:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qrhOglzu;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qrhOglzu; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K7drM1KQpz30H3
 for <linux-erofs@lists.ozlabs.org>; Wed,  2 Mar 2022 13:49:55 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B91F76168E;
 Wed,  2 Mar 2022 02:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F263C340F2;
 Wed,  2 Mar 2022 02:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646189390;
 bh=FysnhgPEa69XwFrDLrSLB1oxl+aL0JbGynml4vaPzbE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qrhOglzuZ0rA7h+F3Z34gKOn7cP8FhkgK5DtxfGcudkObGWZ9iu6H7+5IY6P5exCg
 IBuGYtM6Mz6Lj6dpznP0t8yafIwbLLpe6JLzWBK11AdNMuX/YsstFvGXwbv6nY5dcj
 kVtc0KuDLZ0/jBr4LAnXVrNzh1CdHcnN3R3dqDVc5J/2CPfvJ0stRa+wfNOcIFcIfe
 l2NWO26XVed1z5V6U0/cEewjFdPJ0txOXrfEd8xGe+Fl3DzrPkNLESjrFmtvORaeEt
 tmn63mUPdMe4WJuTS+QPdq3q3/VNkMwnAj+8+Y9Fa1RlulGlBfogeGT1LGsqHWlox9
 Cf7vj8KKa9P2g==
Message-ID: <4c8ce495-a27b-cba7-7a81-26adf9a4c604@kernel.org>
Date: Wed, 2 Mar 2022 10:49:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] erofs: fix ztailpacking on > 4GiB filesystems
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 Yue Hu <huyue2@yulong.com>
References: <20220222033118.20540-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220222033118.20540-1-hsiangkao@linux.alibaba.com>
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

On 2022/2/22 11:31, Gao Xiang wrote:
> z_idataoff here is an absolute physical offset, so it should use
> erofs_off_t (64 bits at least). Otherwise, it'll get trimmed and
> cause the decompresion failure.
> 
> Fixes: ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

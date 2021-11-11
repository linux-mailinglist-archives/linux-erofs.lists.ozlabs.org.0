Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BBC44CFE4
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Nov 2021 03:15:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HqQL761J7z2yNW
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Nov 2021 13:15:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=B7+hf8ui;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=B7+hf8ui; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HqQL455nxz2xDv
 for <linux-erofs@lists.ozlabs.org>; Thu, 11 Nov 2021 13:15:40 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B8E161208;
 Thu, 11 Nov 2021 02:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636596937;
 bh=JFfziBYp+5yDIiX5R0WhB6KaxkyNcCATSA7Yrupceos=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=B7+hf8ui7agF2AGfk4r9ofa+Z5zsDcPerr3Ip474NZ0DICBQ9wCRsPxB9MQJJ7fhp
 BfiMNXR5W2rr89wWgSeT410W3Hwa0YdYDYdAf/UgQ3jWTIgokNdCHDeY3VWtwAsHdF
 YfG4agNlHLX1YcWmkvidRmcT27TvLZnahxygKg2Ovp5X3JJp6rROYCk7wsI8YY46gw
 3R3ObXT+P7AesDkBlBMVtHjsKAOANnG+gM15yaXj+zSQ/GPP7Xh9kSGVfInT46KLWe
 2gs//Onbaptt9SQ/hBrBEri3quEBEV87bcIQtqtJ9kk9QgmdpsYM8R4t2gPR671JpQ
 3pqbqkMBoU+Mg==
Message-ID: <f78e7371-f9ff-32e7-77ef-e6bd17e084aa@kernel.org>
Date: Thu, 11 Nov 2021 10:15:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v4 2/2] erofs: add sysfs node to control sync
 decompression strategy
Content-Language: en-US
To: Huang Jianan <jnhuang95@gmail.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org
References: <20211109153856.12956-1-huangjianan@oppo.com>
 <20211110134846.2707-1-jnhuang95@gmail.com>
 <20211110134846.2707-2-jnhuang95@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211110134846.2707-2-jnhuang95@gmail.com>
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
Cc: yh@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/11/10 21:48, Huang Jianan wrote:
> From: Huang Jianan <huangjianan@oppo.com>
> 
> Although readpage is a synchronous path, there will be no additional
> kworker scheduling overhead in non-atomic contexts. So add a sysfs
> node to allow disable sync decompression.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD374649C4
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Dec 2021 09:35:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J3sqY11dnz306D
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Dec 2021 19:35:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=c1kesvsI;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1;
 helo=sin.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=c1kesvsI; 
 dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J3sqV2zVVz3053
 for <linux-erofs@lists.ozlabs.org>; Wed,  1 Dec 2021 19:35:50 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 23D8BCE1D8E;
 Wed,  1 Dec 2021 08:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06816C53FCC;
 Wed,  1 Dec 2021 08:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638347743;
 bh=Edd2Sg1pgOiEKZQk3K6Ud9i3/8hNRHv6J85ZiZxD9DY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=c1kesvsIsdnLwUxKALXieMKdpTnhiOU8bprDZV8uzK58beSb3t5AyC8mMcLi35uou
 9z3VsFY0zlRsRl4DlMHO5QGpyCTAdvNxtexV0X40YEOJlehiYRu0ZyP5UCsAAK6sj6
 MypZ+3ym8OCfutKkDwdALkG0qngBbLXXF66RX332a2EP+b8berSMMD9K40ztXWLouK
 EGmGnrGP7EDw/cs02y4NytmnzqPSd+sVvTaGLVMNN8zOLR0BfxhgKStzvqwEeot2uQ
 J6NeGFJlbA9EIw7I1ar3u9eumcpUHum5C9Qse9t+nh1Fj8qbxJ1y+Nk/zdPWWupSaU
 E7+b+SkPjuUxw==
Message-ID: <0dcd8cb3-832a-464a-fb02-fe6138363487@kernel.org>
Date: Wed, 1 Dec 2021 16:35:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] erofs-utils: update AUTHORS
Content-Language: en-US
To: Huang Jianan <huangjianan@oppo.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org
References: <20211201082746.1642-1-huangjianan@oppo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211201082746.1642-1-huangjianan@oppo.com>
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

On 2021/12/1 16:27, Huang Jianan wrote:
> Add myself to the AUTHORS file.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

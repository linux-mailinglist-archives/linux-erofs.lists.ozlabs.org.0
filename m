Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AC966BFDE
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Jan 2023 14:34:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NwY0x12BCz3cHF
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Jan 2023 00:34:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FE/nssb7;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FE/nssb7;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NwY0R3N9Gz3cGh
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Jan 2023 00:34:31 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B153E60FB8;
	Mon, 16 Jan 2023 13:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43F7C433D2;
	Mon, 16 Jan 2023 13:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673876068;
	bh=WcgBqWBBbr2xY0y9OSmKDrWJ1dy4pHSO/ay/B1iCOQk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FE/nssb7tvG5AEes41B6uIOkMvFgWFv+bXN3zmZvmso4RU/fB8OO8RXlpvBuOjGX2
	 ARZ/AaRV5iiuYyaIDXyuPddkpx+0S37tj3dg4/KcEMCyU3Jz6jDn4utgsMDMgXe4QW
	 7Bm6DDd7JGJUlADYattitgNiwC9Y2JRr4BTqvKkdCnILyxvk9WYkIgt1Uu8e1MCiwD
	 2ViH2skpneqHABvg3IZsbtjHiE93AxcrTiLkD0MfPQBP7V2Hg72okoGtesMDKaVvfJ
	 66/MXfJ+4piYAP+X+H4scdqTzZmcknPXhkQXBHOCVz9UagTIkixaP8H5aMrsKVtML8
	 XWlvVqO75gmSg==
Message-ID: <b169fa37-0bfb-fbdc-efc2-c4f30638760a@kernel.org>
Date: Mon, 16 Jan 2023 21:34:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/2] erofs: clean up parsing of fscache related options
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20230112065431.124926-1-jefflexu@linux.alibaba.com>
 <20230112065431.124926-3-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230112065431.124926-3-jefflexu@linux.alibaba.com>
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
Cc: huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/1/12 14:54, Jingbo Xu wrote:
> ... to avoid the mess of conditional preprocessing as we are continually
> adding fscache related mount options.
> 
> Reviewd-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Reviewed-by: Yue Hu <huyue2@coolpad.com>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

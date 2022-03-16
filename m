Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD824DA773
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 02:45:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KJClF5nPRz308B
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 12:45:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=btTYa+mo;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1;
 helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=btTYa+mo; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KJClB4gC6z2xX8
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Mar 2022 12:45:10 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 01529B81A0D;
 Wed, 16 Mar 2022 01:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A26EC340E8;
 Wed, 16 Mar 2022 01:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647395106;
 bh=vpvK34JgD/Hy/2DxTDfEm3ZyCtrp5fVfbCVJ8tXBe64=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=btTYa+moocnIpxfd6M3ua1Ui/3qo56O73y3EK1nfHY6J0VlbzlrFeZEm1HkkkFf9A
 QQnyFsy+uPwFep4tJ6Y8wE6FEXPDwv2o2UiDo6WmGDlA3sDqRekXvMgHdC6XiBtpeS
 VANx2NwbeoEjQQiAeGf2gitivxQ3QHwUxMEYIF/Bof48OE3fVUr6ePEVG0nDy73twq
 nTnMppfZ/ZkDG6FnDhcn5w5Juf1aQc+9nF1WtzpP1lrICW5gUrompjZaax8KSbWZgH
 yq/TTDxp3KigoU+RyoWea27Nz+FluMsS1yT685nortjh9K0KPcJ93Fk0x0GdyN2i6f
 AYSocb0EQ7O8g==
Message-ID: <871e075f-9c11-7baf-c3c4-8541fafa101b@kernel.org>
Date: Wed, 16 Mar 2022 09:45:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] fs: erofs: add sanity check for kobject in
 erofs_unregister_sysfs
Content-Language: en-US
To: Dongliang Mu <dzm91@hust.edu.cn>, Gao Xiang <xiang@kernel.org>
References: <20220315132814.12332-1-dzm91@hust.edu.cn>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220315132814.12332-1-dzm91@hust.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org, Dongliang Mu <mudongliangabcd@gmail.com>,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/3/15 21:28, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'. This bug
> is triggered by injecting fault in kobject_init_and_add of
> erofs_unregister_sysfs.
> 
> Fix this by adding sanity check for kobject in erofs_unregister_sysfs
> 
> Note that I've tested the patch and the crash does not occur any more.
> 
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

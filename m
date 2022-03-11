Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72094D5D08
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 09:07:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KFJSj3bqsz2xXX
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 19:07:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LEIMdtKH;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=LEIMdtKH; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KFJSd4S5Qz2xXX
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Mar 2022 19:07:29 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8B3ECB82AD2;
 Fri, 11 Mar 2022 08:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3B6C340E9;
 Fri, 11 Mar 2022 08:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646986045;
 bh=fF65DkD4a2bE9G4hkIRLwERxisrywH22WBfSghyp7H8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LEIMdtKH+RuJ1l5tLAQp9YsP70C0tUGa7IB8Km6d8FZuUdOTawMz/6SisPpisEx8c
 uk97ncsM6cskBpaJybtnYGu/REDwmCOqPgoYXOjKohj3qZ2iyoKDJLCV8IZc6u35bD
 24DL2Zyo/zp7Up4sgBwLALlP3UY8l4AMnhjbuMyG8dL9RZFC+Y0m3LVQSkpc7W4vJy
 lodEZPEfk79eXsfrZCWfNapNe6Eg4Itn3hi8G7RnmHkJZ8TDLXMVjqOlalYjifacaA
 C2tH6pZkHm835rHSWtDIzkuUPW6HyIlkueSJXJZWPr1PW1eUJBSQMcGvsvzW6Jcd5L
 BsyaP3muzyLrw==
Message-ID: <0e4102f4-2f3d-ac4c-a630-c6f6d24dc156@kernel.org>
Date: Fri, 11 Mar 2022 16:07:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/2] erofs: get rid of `struct z_erofs_collector'
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20220301194951.106227-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220301194951.106227-1-hsiangkao@linux.alibaba.com>
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

On 2022/3/2 3:49, Gao Xiang wrote:
> Avoid `struct z_erofs_collector' since there is another context
> structure called "struct z_erofs_decompress_frontend".
> 
> No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

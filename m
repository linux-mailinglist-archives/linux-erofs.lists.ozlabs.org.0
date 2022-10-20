Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D181F605959
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Oct 2022 10:10:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtKyv721Sz3c7V
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Oct 2022 19:10:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RUrUJY+Z;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RUrUJY+Z;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtKyp038Bz3bjh
	for <linux-erofs@lists.ozlabs.org>; Thu, 20 Oct 2022 19:10:09 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 4FEC1B8269E;
	Thu, 20 Oct 2022 08:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458F4C433D7;
	Thu, 20 Oct 2022 08:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666253403;
	bh=TZH3HlrUcw85qXpZBg1C/yHHkc3IDLD5ROD1X0bKVM8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RUrUJY+ZQID6beKKY8k/RIFOChFc6D1S84jdodkaPggjPAtO3AfUyUWiYQIuE3MEP
	 zaL6Gtg63O0Fe0KWa/SsjRS3BcUlJ5ASCyxCaXQzK4SPlIkG7czgBPbpCJ6bRGDFbu
	 jBQeGqIH5kTj8k8x8lZnbvBFdiCfrXzhkCM6xjdMbHWJ9OrrKuVD1sWKApkksSKoy1
	 Ov0WKaEGoOssY3kM2nJdPhZ8S9frYiSwASv9nTPhshse4s2gITPwGhvf2yppCScqrM
	 BAm2v3bjBh2Xb+pTHmKQKrFelaDDB8iJePbq3q37+KX2DngBF7IDCeqhV2KvfyBSOG
	 fuT8Z8hw2l0Kg==
Message-ID: <0b2d44b0-7a72-2788-b8cc-b5c1ecfbcbae@kernel.org>
Date: Thu, 20 Oct 2022 16:09:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] erofs: protect s_inodes with s_inode_list_lock
Content-Language: en-US
To: Dawei Li <set_pte_at@outlook.com>, xiang@kernel.org
References: <TYCP286MB23238380DE3B74874E8D78ABCA299@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <TYCP286MB23238380DE3B74874E8D78ABCA299@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/10/17 9:55, Dawei Li wrote:
> s_inodes is superblock-specific resource, which should be
> protected by sb's specific lock s_inode_list_lock.
> 
> v2: update the locking mechanisim to protect mutual-exclusive access
> both for s_inode_list_lock & erofs_fscache_domain_init_cookie(), as the
> reviewing comments from Jia Zhu.
> 
> v1: https://lore.kernel.org/all/TYCP286MB23237A9993E0FFCFE5C2BDBECA269@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
> 
> base-commit: 8436c4a57bd147b0bd2943ab499bb8368981b9e1
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

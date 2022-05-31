Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8544C5389EA
	for <lists+linux-erofs@lfdr.de>; Tue, 31 May 2022 04:27:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LBx4t04Tsz3bXg
	for <lists+linux-erofs@lfdr.de>; Tue, 31 May 2022 12:27:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MSKhoeU1;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MSKhoeU1;
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LBx4n2PwPz2xss
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 May 2022 12:27:21 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id EA638CE0E2E;
	Tue, 31 May 2022 02:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0555BC385B8;
	Tue, 31 May 2022 02:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653964036;
	bh=/jTuVM6LQOkDhYQ27dssQ0//PORfYGXznbKphQM81yI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MSKhoeU16oCEC9qsEukm6XYeEDtlPNhEB4f5h2JakvKL0ViqAbiL86SalCB2FUl7S
	 PZ6Vw1sOqqsN71xlZ4RVeWicxejcyLgMmEJTW4eFemhd7sby0Jze+vREkAl4b5V2Wk
	 2yOAJ4KsIFH9q6aysnWsFDrSPioyNSqy5Nw2YnswOxIoqOkxg908kS6CJ53mscqefI
	 3hMkSbZoUreqOJu4qZJUQy3bHIsozgCkuxzi2SXPC3l61zs8InoTJIoZ3OHM0hqmVw
	 L8NTmJEXMLLoA0Oic7pa0zNjGxkswgpi6iLHOvnB4kGHxRvik2SxnhdvpkIjM+8MZV
	 4yKxm5XuAnJ4Q==
Message-ID: <474be4e3-59e7-b90f-0bde-642c2c67f272@kernel.org>
Date: Tue, 31 May 2022 10:27:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] erofs: fix 'backmost' member of
 z_erofs_decompress_frontend
Content-Language: en-US
To: Weizhao Ouyang <o451686892@gmail.com>, Gao Xiang <xiang@kernel.org>,
 Yue Hu <huyue2@coolpad.com>
References: <20220530075114.918874-1-o451686892@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220530075114.918874-1-o451686892@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/5/30 15:51, Weizhao Ouyang wrote:
> Initialize 'backmost' to true in DECOMPRESS_FRONTEND_INIT.
> 
> Fixes: 5c6dcc57e2e5 ("erofs: get rid of `struct z_erofs_collector'")
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

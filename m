Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CE34E518D
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Mar 2022 12:45:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KNmkd0Cxdz2yyf
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Mar 2022 22:45:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yTrCs3UH;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4601:e00::1;
 helo=ams.source.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=yTrCs3UH; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KNmkV2Cgjz2y8P
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Mar 2022 22:45:20 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id EF2FEB81E86;
 Wed, 23 Mar 2022 11:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B4FC340E9;
 Wed, 23 Mar 2022 11:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1648035914;
 bh=IxpqzFI6WpDddlfyiBF2wn59Avf/l0dP3T+qrOocd+A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yTrCs3UHixDyJX/Led6DPpdXFOlXJxVE01dbxPBveuAhCrsqoH/gqsjSlooQX7n/V
 g4aKYNEAHUfcMowFHxXkY2NvZT/h3pGoCL+7RnymvWhXSHIeSR2RZL5I2YDtm5Lvha
 ktycQqB4uaNQt5ec+MtA8Kqr2OSmz4B9rAdbiheE=
Date: Wed, 23 Mar 2022 12:45:11 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?55Sw5a2Q5pmo?= <tianzichen@kuaishou.com>
Subject: Re: [PATCH v5 00/22] fscache, erofs: fscache-based on-demand read
 semantics
Message-ID: <YjsIR886wCKosNNu@kroah.com>
References: <B6EA31D4-877C-450E-BF89-2879044B9EAD@kuaishou.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B6EA31D4-877C-450E-BF89-2879044B9EAD@kuaishou.com>
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
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "willy@infradead.org" <willy@infradead.org>,
 "dhowells@redhat.com" <dhowells@redhat.com>,
 "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
 "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
 "luodaowen.backend@bytedance.com" <luodaowen.backend@bytedance.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "gerry@linux.alibaba.com" <gerry@linux.alibaba.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Mar 23, 2022 at 08:38:07AM +0000, 田子晨 wrote:
> This solution looks good, and we’ re also interested  in it ,  please accelerate its progress so we can use it.

Please test the patches and provide your feedback on it (i.e.
"Reviewed-by:" and the like.)

thanks,

greg k-h

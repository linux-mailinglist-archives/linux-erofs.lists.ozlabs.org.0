Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AE28FDDF6
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 06:56:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VvsVr5620z3cVG
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 14:56:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=deepin.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=deepin.org (client-ip=52.205.10.60; helo=smtp-usa1.onexmail.com; envelope-from=heyuming@deepin.org; receiver=lists.ozlabs.org)
Received: from smtp-usa1.onexmail.com (smtp-usa1.onexmail.com [52.205.10.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VvsVl3K3rz30W9
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Jun 2024 14:56:30 +1000 (AEST)
X-QQ-mid: bizesmtp82t1717649747t72bvcjb
X-QQ-Originating-IP: y8ldQwnCFbpN2rpTTKBLNlt3bWqIcanGoFw0hDCX2IA=
Received: from [198.18.0.1] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Jun 2024 12:55:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8133746200025661711
Message-ID: <FCCC4CD56F7BD7A7+38f6db53-8b1d-4c33-b6a3-3c867fc74a9f@deepin.org>
Date: Thu, 6 Jun 2024 12:55:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: hsiangkao@linux.alibaba.com
Content-Language: en-US
From: ComixHe <heyuming@deepin.org>
Subject: Re: [PATCH] build: support building static library
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:deepin.org:qybglogicsvrsz:qybglogicsvrsz3a-1
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

According to your suggestions:

 > That is also fine with me, anyway, liberofsfuse is a very special
 > case for us, I'd like to just build a static library for
 > erofsfuse only (because liberofs will be exported as a dynamic
 > library in later versions, I don't want to rely on random libfuse
 > interface).
 >
 > For other usage, I'd suggest form some formal APIs in liberofs
 > instead.

I create a new patch which only for exporting 'liberofsfuse.a'.

Thanks,

He YuMing


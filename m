Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD7D629557
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Nov 2022 11:09:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NBMNy44V8z3cKG
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Nov 2022 21:09:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1668506994;
	bh=y0KP37fL06Ddkt/t9va+97Mqv3/Ml7gCQQoFspXKKGs=;
	h=Date:To:References:Subject:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Dqxmub3e5AiF51Jq0JTrH6AEdwsFqWgpLUNEg440ngrc1ZKiUvplxJydidXhPCbMx
	 mbz0kzfiLlSzNaTt/bP3wC9pNlDiXegbOKuTicxTgmN6iOnW28tJatqbTTjjsOKIaD
	 XSzhklvs23dAyX2ccUYenog9oihReK/c3AnGNhI0VCoICKQfEG4YbsZRhY8vUYqoZn
	 gR0UtUv8xRybKFUimh8A9z7t62Zz4Yo8z+GMb2shGaR9phSm2yI3J467dwNsIDSzyV
	 xN97Y5QSQRhJ59QZ/frW/zM1oKps0NloNqKjmwVpqITaHxePjMno9JGosa8w5brRUZ
	 S16oSWWRdgnDg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siddh.me (client-ip=103.117.158.50; helo=sender-of-o50.zoho.in; envelope-from=code@siddh.me; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=siddh.me header.i=code@siddh.me header.a=rsa-sha256 header.s=zmail header.b=qU1QmqML;
	dkim-atps=neutral
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NBMNr21cMz3cD7
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Nov 2022 21:09:47 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1668506982; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=CW4l41oR7KZQwFhNoYv0OJy8Cd2JSMsS6ZSkl1BGBJPIFgEtzLbklxeWRT3PjxH8tpznsDCokee2X62/26iUdnNZ1C72IAhauCouyUADqO72AXWPxQCPvNTe9n1CGvl1KpMWE30PFYiKyT098QSsoxyRRy2DC+LHnFP7Q4QkI0M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1668506982; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=y0KP37fL06Ddkt/t9va+97Mqv3/Ml7gCQQoFspXKKGs=; 
	b=Nj4LfgTwYNFtHzNUDBzXcaNRFOI6OdF0Pv4hvEH9ULQjLaGvsErMhAGL9GzwgFS9tchP5+iYkIgDcaReIZJyhvk25AX2Xqodcf0bLke1aFn7MIcYobCOM5IBoPxd42MdnQaWcHVUIIUulrUCgxpiDB4lulEw35C0S867R6txvnw=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
Received: from [192.168.1.9] (110.226.30.173 [110.226.30.173]) by mx.zoho.in
	with SMTPS id 1668506981538751.4796566831048; Tue, 15 Nov 2022 15:39:41 +0530 (IST)
Message-ID: <917344b4-4256-6d77-b89b-07fa96ec4539@siddh.me>
Date: Tue, 15 Nov 2022 15:39:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <Y3MGf3TzgKpAz4IP@B-P7TQMD6M-0146.local>
Subject: Re: [RFC PATCH] erofs/zmap.c: Bail out when no further region remains
Content-Language: en-US, en-GB, hi-IN
In-Reply-To: <Y3MGf3TzgKpAz4IP@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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
From: Siddh Raman Pant via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Siddh Raman Pant <code@siddh.me>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>, linux-erofs <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 15 Nov 2022 08:54:47 +0530, Gao Xiang wrote:
> I just wonder if we should return -EINVAL for post-EOF cases or
> IOMAP_HOLE with arbitrary length?

Since it has been observed that length can be zeroed, and we
must stop, I think we should return an error appropriately.

For a read-only filesystem, we probably don't really need to
care what's after the EOF or in unmapped regions, nothing can
be changed/extended. The definition of IOMAP_HOLE in iomap.h
says it stands for "no blocks allocated, need allocation".

Alternatively, we can return error iff the length of the
extent with holes is zero, like here.

Thanks,
Siddh

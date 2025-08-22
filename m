Return-Path: <linux-erofs+bounces-875-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E9AB312E8
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Aug 2025 11:25:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7ZY71v88z30gC;
	Fri, 22 Aug 2025 19:25:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755854731;
	cv=none; b=lbzvy/uv4O252ibjX8MmZknwbyUifuAjnzRQN6lsiXdvNrsVKW++W9a3Q0W7TR4hBZ1halNimoTmVEVDCKhz264UqWFhuvE85LEtCQeoAK1udAdrTw5xqWJYj0zbuMlts5YzrXZormLBLJ3Juj3mYX9FeB0myXpPkI3GZwklxlETM1Lcc04GRrRO+n6S6US9QCLzBK9q4cR0NaZQ0dt8AJPm0bWdEMCZxFZVRZEDyYeTt0sDk34sYWxroEZENwnRxKbMtfPmjVlX/tBOUilZdSCaJxf1gp3zpaVhxc1Ly4vHMDi1wyzBp2MCJ5JcOCwx+w6eVlEPumV1faD578Wi8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755854731; c=relaxed/relaxed;
	bh=Vsj8k7rvi2PVfD9qED4+VsLxAvBQ45+VStfNgj/+vjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBYHEPcLE6mwq08+UTgaANmJRKDJRT3fB6W+y7ediOgYeV3S9uOKaVW/f00kFWPpMQDMvioySm2g/HEp+ma4f9THnSoa9W+wm0FygUwHdsjBEQXwxSWchZx8e5R3M6I9AOetAcYCIM0ZyxqkUdgwwfWHrGBBPAlOR1z8CVtSRWfmJwzLczhCeLFOV0aj3tjIg6lgkL5b97Q8T74z4XQjq4vFq+I0Rc0v2HRYVSIwIt0ksWXoA5gcUISwtiV79kR298U7QeuCjVWMLs8pVeGF9gcEmKHf65UJqiFQMFM83Etw2Dk+l5iIDaFzcOTAfSgGAXfq6TBCRKYNZqYxOV295w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BwJbNC7u; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BwJbNC7u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7ZY526Hdz2xd4
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Aug 2025 19:25:27 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755854724; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Vsj8k7rvi2PVfD9qED4+VsLxAvBQ45+VStfNgj/+vjk=;
	b=BwJbNC7uLhFarSBps5HrfOb8xMtEPn+EjgNiKhModFuVKu/ftslJPwP6IjKKY91m8rJDnesOWi+u/HT2k5S++vYElHizrpX7+Qx3IQHSLubrOu3nyQY/6g8tG9OSS480K6AWb1peJ8IZE7wFWlW6SBtBcjueI0I5K5kpVC1w+L4=
Received: from 30.221.131.67(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmJJCti_1755854722 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 22 Aug 2025 17:25:22 +0800
Message-ID: <fa5a72ad-8e69-4ecf-9b65-de91f2384289@linux.alibaba.com>
Date: Fri, 22 Aug 2025 17:25:21 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: mkfs: Implement 'dsunit' alignment on
 blobdev
To: "Friendy.Su@sony.com" <Friendy.Su@sony.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Cc: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 "Daniel.Palmer@sony.com" <Daniel.Palmer@sony.com>
References: <20250822084241.170054-1-friendy.su@sony.com>
 <ab8c4834-a2f4-4b04-a797-5fb3ab3f9e40@linux.alibaba.com>
 <TY0PR04MB6191308433B54530F009868EFD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <TY0PR04MB61910BB1A38FE11C4F80B0C2FD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <TY0PR04MB61910BB1A38FE11C4F80B0C2FD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/22 17:19, Friendy.Su@sony.com wrote:
>> +             off_t off = lseek(blobfile, 0, SEEK_CUR);
>> +
>> +             erofs_dbg("Try to round up 0x%llx to align on %d blocks (dsunit)",
>> +                             off, sbi->bmgr->dsunit);
>> +             off = roundup(off, sbi->bmgr->dsunit * erofs_blksiz(sbi));
>> +             if (lseek(blobfile, off, SEEK_SET) != off) {
>> +                     ret = -errno;
>> +                     erofs_err("lseek to blobdev 0x%llx error", off);
>> +                     goto err;
>> +             }
>> +             erofs_dbg("Aligned on 0x%llx", off);
> 
> Could we combine these two debugging messages into one?
> 
> Here, 'off' is changed after roundup(), we need show both 'before' and 'after' by one variable 'off',  it is hard to combine.
> Do you have better idea? ^_^

It's just a debugging message, just wonder if
the previous position is important?

If it's really important, you could use another variable
to keep the original one.

Thanks,
Gao Xiang


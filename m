Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FB99C3667
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 03:09:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XmtK726xgz2yYq
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 13:09:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731290969;
	cv=none; b=mVmcZCYfmHuahRa2RByQI4UMNMPZdsIsQCL2nhR7++ocDzKpjgBRq/0nmwSNMJKseP172Mh1u7xP88uRSkczXZDESkHl8gNaAbbV9F6LcXB5gmT4KDiDJgtKHNV0pcnm3DX5c7A3KJNsCVO8FXPzAq54qbHoOqE+hBtN1D/QqzkDyuX2EJ2dLvEhFi6VYAjjtDmQ4QytYwnC4XUsrB8+lmClQPSJJaZdYsVqdL+vIxBHF5WWGGavCOKHzn12nG6ZDSMazN8a1QrJgF4fezt4H8JiOI0WE7mqS3gkNL5XXopNIRXHGsYox6JTZ+I8cJ2+cBBq8zvb6Wqeba5vONR5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731290969; c=relaxed/relaxed;
	bh=EkHq5ULh5nBblruZP9s1KkDsvhW94OirglM9nAXKs8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npLj428Nj9/sgXvco++eOiCvH1SMABvj83KlhBkZ0wPuZL0S1csUeqC9kLOazCu+RT73b/390WH/3O+isLc2S75D9cGvoYiGYFMZBqf6h1JgTPecgPmDS2pJN3hheyDnc26ZgSSlCzrNJFll/NNxBRwQTz3lqugrNA+YUJU0O5PCpFsMkDFp6Q28YL55TN6AzDtT34pBDa6ADBbzuMVuiKW2pYJPODjj4nKhBzj9JLJai/4mI7auxzlVVFXjcmjKgdJE+deikgN8WtYAXVJU3vewGXmQz8s7Zq32wxG1tUJsIrPp8VQSBb9Muec6IBBC8hHBg5THyBPrjkdZcaDgGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=W6rPBvjg; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=W6rPBvjg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XmtJy6Yscz2xgp
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Nov 2024 13:09:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731290953; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EkHq5ULh5nBblruZP9s1KkDsvhW94OirglM9nAXKs8A=;
	b=W6rPBvjgezNwPK4k/E2p013opsqR+GRkEubmkzWm1Q6gRLVQjv3zqTZOi1r7IAAVjMIoskrbC8hvRUKneHHa2z1ytp52a95lZnaPpW/tNGvplAbeySLAn2Sol3+kmbcNIkVCS97Ow1E1QIAHK+xvNy72IlGnAR+O+jXmCoPq3jE=
Received: from 30.221.130.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJ3xVzO_1731290951 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 10:09:11 +0800
Message-ID: <02a3a22d-782b-434b-b3e6-5138f77ee251@linux.alibaba.com>
Date: Mon, 11 Nov 2024 10:09:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mkfs: Fix input offset counting in headerball mode
To: Mike Baynton <mike@mbaynton.com>
References: <20241024195801.1546336-1-mike@mbaynton.com>
 <bfbf180e-21d6-45de-b4c9-43089dcef333@linux.alibaba.com>
 <CAM56kJTuwXoOtQ+V7YHygHhHb--9qUmvkbADOuG=-4zwHvfkzQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAM56kJTuwXoOtQ+V7YHygHhHb--9qUmvkbADOuG=-4zwHvfkzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: sam@posit.co, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Mike,

On 2024/11/9 00:37, Mike Baynton wrote:
> Thanks for the update, Gao! Appreciate your review.
> 
> Mike

I'm just back from vacation.

> 
> On Fri, Oct 25, 2024 at 8:36 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> Hi Mike,
>>
>> On 2024/10/25 03:58, Mike Baynton wrote:
>>> When using --tar=headerball, most files included in the headerball are
>>> not included in the EROFS image. mkfs.erofs typically exits prematurely,
>>> having processed non-USTAR blocks as USTAR and believing they are
>>> end-of-archive markers. (Other failure modes are probably also possible
>>> if the input stream doesn't look like end-of-archive markers at the
>>> locations that are being read.)
>>>
>>> This is because we lost correct count of bytes that are read from the
>>> input stream when in headerball (or ddtaridx) modes. We were assuming that
>>> in these modes no data would be read following the ustar block, but in
>>> case of things like PAX headers, lots more data may be read without
>>> incrementing tar->offset.
>>>
>>> This corrects by always incrementing the offset counter, and then
>>> decrementing it again in the one case where headerballs differ -
>>> regular file data blocks are not present.
>>>
>>> Signed-off-by: Mike Baynton <mike@mbaynton.com>
>>
>> Sorry for late reply, I'm busy in personal stuffs now.
>> I will look into these cases and reply again later.

Yeah, thanks for the nice catch!  Yet I'm not sure if
decreasing `tar->offset` so late is safe (because there
are potential early exits here).

So how about the following diff? If it looks good to you
too, could you submit another version for this?

diff --git a/lib/tar.c b/lib/tar.c
index b32abd4..990c6cb 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -808,13 +808,14 @@ out_eot:
  	}

  	dataoff = tar->offset;
-	if (!(tar->headeronly_mode || tar->ddtaridx_mode))
-		tar->offset += st.st_size;
+	tar->offset += st.st_size;
  	switch(th->typeflag) {
  	case '0':
  	case '7':
  	case '1':
  		st.st_mode |= S_IFREG;
+		if (tar->headeronly_mode || tar->ddtaridx_mode)
+			tar->offset -= st.st_size;
  		break;
  	case '2':
  		st.st_mode |= S_IFLNK;

Thanks,
Gao Xiang

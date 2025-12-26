Return-Path: <linux-erofs+bounces-1611-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD94CDE6F6
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Dec 2025 08:42:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dcyJR5SGwz2xg9;
	Fri, 26 Dec 2025 18:42:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766734967;
	cv=none; b=go5xP7Ymdq+G0XqMq6HghDNzUr9dbi1l0G8JEBes4A0m5Cr59bcSq8e80rTjUpxAuWZ+YHZ2/9//as6cLX9UWNsTDLIvGroiny2cUAinFK1ZU95MY0On19RBQVoix94Y+Xtk1ST4GqVeExUXY9fFIWRCVBDK77I+Aj6OpPrSUo11E+wwwMgM3sMyKaskNSzelzqX8E6vRQvm5sh4ygEDhPG0EHZQpYcU3OpFp7dF+6AyUMDCoNDPp+CRcTFuAqooZRY121w0YoS79ea11aAJcw02ITl+P+ZkZYQQP4YjqVvXPTD9dX4oToZQbj9UiaAW0jRYmun22178WEETrzuA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766734967; c=relaxed/relaxed;
	bh=+LH17YviHpAqqgh3eT3wL9e+D4C+YPYdRm5IaDbS45U=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:CC:
	 References:From:In-Reply-To; b=SPmmprvVy14zno5VkevP3GL/aDdKZQTws1c2SH2UPXgKCOBb5WyIUHQFFyzoAJX7CyV/p7n/wz/VlT+opzyW/XnNsaupdLN9NVXF3f13Wqc5p9qH7gppwTtmegka1/FY5oMJgUFbKzcz0aV+YE5rf00RvZjrMyoA0kMn4Yfv6qLXbNkWd5RqPgVoqJqcMWpg7ERsrZZnTDsTXIHCeLm0ZQ/TgY+f4GnlYybS8jnJ/iBsPgNSCaXTl5iYQ4oDHP5aqXblyznzt465u4/kM4qVd+TEJ5n7HLRT5rJrsSwdwW5wlEtxzmFDjjHKhM42Nt7lRpXbmAnv8LZ/v8JVU3e8ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=bcpNxgsI; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=bcpNxgsI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dcyJN1j1fz2xcB
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Dec 2025 18:42:41 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+LH17YviHpAqqgh3eT3wL9e+D4C+YPYdRm5IaDbS45U=;
	b=bcpNxgsIJvjZqs4GHN7SbWuiia+VnYZjS8MbdgcgbAMSQWSLNLSQ19z1vsdQmLpUdHIFFaM4L
	GEz1z+DHV1LmBrPwywWmAvpEdd8nh6H3htLAFX0mKtl0pOL7UAa+cOsmZN1iBnCcDFx0mdaat+r
	RbJxUuY1lvRhm/bCTicncWI=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dcyDX5c0czRhRZ;
	Fri, 26 Dec 2025 15:39:24 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 378E640363;
	Fri, 26 Dec 2025 15:42:33 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 26 Dec 2025 15:42:32 +0800
Content-Type: multipart/alternative;
	boundary="------------DZa0ORCW82SLQ2lM7Eo74avH"
Message-ID: <482f9f53-6b3a-4f79-b05d-02a933dcf2c8@huawei.com>
Date: Fri, 26 Dec 2025 15:42:32 +0800
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
Subject: Re: [PATCH 2/5] erofs-utils: mount: Refactor NBD connection logic in
 erofsmount_nbd()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>
References: <20251223100452.229684-1-zhaoyifan28@huawei.com>
 <706b0839-ab0f-4f66-959e-74152a4e1243@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <706b0839-ab0f-4f66-959e-74152a4e1243@linux.alibaba.com>
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--------------DZa0ORCW82SLQ2lM7Eo74avH
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 2025/12/26 14:57, Gao Xiang wrote:
>
>
> On 2025/12/23 18:04, Yifan Zhao wrote:
>> From: Yifan Zhao <yifan.yfzhao@foxmail.com>
>>
>> The current NBD connection logic has the following issues:
>>
>> 1.It first tries netlink (forking a child), then falls back to ioctl
>> (forking another), causing redundant process overhead and double-opening
>> of erofs_nbd_source on fallback.
>
> But I don't want to open source on the main process.  Especially if we'd
> like to trigger multiple layers.
>
> If you really want to optimize this, how about just forking one child
> process for both netlink and ioctl, and opening erofs_nbd_source in
> the child process too.
>
yeah, this is exactly what this patchset did, one child for both netlink 
and ioctl.
>> 2.Child processes fail silently, hiding the error cause from the parent
>> and confusing users.
>> 3.erofsmount_startnbd() doesn’t ignore SIGPIPE, causing nbd_loopfn to be
>> killed abruptly without clean up during disconnect.
>> 4.During disconnect, -EPIPE from NBD socket I/O is expected, but
>> erofsmount_nbd_loopfn() does not suppress it, leading to uncessary
>> "NBD worker failed with EPIPE" message printed in erofsmount_startnbd().
>
> Could we address these issues independently?

Fixing issue 2 is limited by the current thread model (previous 'double 
error print') problem.

Issue 3 & 4 are almost identical; however, fixing them under the current 
codebase would

require additional modifications after this patch is merged. That’s why 
I’ve included them in

this patch. I believe they could alternatively be deferred and addressed 
separately in a subsequent patch.

Thanks,

Yifan

>
> Thanks,
> Gao Xiang
>
>>
>> This patch consolidates the netlink and ioctl fallback logic into a
>> single child process, eliminating redundant erofs_nbd_source opens. It
>> also ensure SIGPIPE and -EPIPE are properly suppressed during disconnect
>> in erofsmount_nbd_loopfn(), enabling cleanup and graceful exit.
>> Additionally, the child process now reports error code via exit() for
>> better user visibility.
>>
>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>
--------------DZa0ORCW82SLQ2lM7Eo74avH
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025/12/26 14:57, Gao Xiang wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:706b0839-ab0f-4f66-959e-74152a4e1243@linux.alibaba.com">
      <br>
      <br>
      On 2025/12/23 18:04, Yifan Zhao wrote:
      <br>
      <blockquote type="cite">From: Yifan Zhao
        <a class="moz-txt-link-rfc2396E" href="mailto:yifan.yfzhao@foxmail.com">&lt;yifan.yfzhao@foxmail.com&gt;</a>
        <br>
        <br>
        The current NBD connection logic has the following issues:
        <br>
        <br>
        1.It first tries netlink (forking a child), then falls back to
        ioctl
        <br>
        (forking another), causing redundant process overhead and
        double-opening
        <br>
        of erofs_nbd_source on fallback.
        <br>
      </blockquote>
      <br>
      But I don't want to open source on the main process.  Especially
      if we'd
      <br>
      like to trigger multiple layers.
      <br>
      <br>
      If you really want to optimize this, how about just forking one
      child
      <br>
      process for both netlink and ioctl, and opening erofs_nbd_source
      in
      <br>
      the child process too. <br>
      <br>
    </blockquote>
    yeah, this is exactly what this patchset did, one child for both
    netlink and ioctl.
    <blockquote type="cite"
      cite="mid:706b0839-ab0f-4f66-959e-74152a4e1243@linux.alibaba.com">
      <blockquote type="cite">2.Child processes fail silently, hiding
        the error cause from the parent
        <br>
        and confusing users.
        <br>
        3.erofsmount_startnbd() doesn’t ignore SIGPIPE, causing
        nbd_loopfn to be
        <br>
        killed abruptly without clean up during disconnect.
        <br>
        4.During disconnect, -EPIPE from NBD socket I/O is expected, but
        <br>
        erofsmount_nbd_loopfn() does not suppress it, leading to
        uncessary
        <br>
        "NBD worker failed with EPIPE" message printed in
        erofsmount_startnbd().
        <br>
      </blockquote>
      <br>
      Could we address these issues independently?</blockquote>
    <p>Fixing issue 2 is limited by the current thread model (previous
      'double error print') problem.</p>
    <p>Issue 3 &amp; 4 <span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">are almost identical; however, fixing them under the current codebase would</span></p>
    <p><span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">require additional modifications after this patch is merged. That’s why I’ve included them in</span></p>
    <p><span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">this patch. I believe they could alternatively be deferred and addressed separately in a subsequent patch.</span></p>
    <p><span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">
</span></p>
    <p><span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Thanks,</span></p>
    <p><span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Yifan</span></p>
    <blockquote type="cite"
      cite="mid:706b0839-ab0f-4f66-959e-74152a4e1243@linux.alibaba.com"> <br>
      Thanks,
      <br>
      Gao Xiang
      <br>
      <br>
      <blockquote type="cite">
        <br>
        This patch consolidates the netlink and ioctl fallback logic
        into a
        <br>
        single child process, eliminating redundant erofs_nbd_source
        opens. It
        <br>
        also ensure SIGPIPE and -EPIPE are properly suppressed during
        disconnect
        <br>
        in erofsmount_nbd_loopfn(), enabling cleanup and graceful exit.
        <br>
        Additionally, the child process now reports error code via
        exit() for
        <br>
        better user visibility.
        <br>
        <br>
        Signed-off-by: Yifan Zhao <a class="moz-txt-link-rfc2396E" href="mailto:zhaoyifan28@huawei.com">&lt;zhaoyifan28@huawei.com&gt;</a>
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------DZa0ORCW82SLQ2lM7Eo74avH--


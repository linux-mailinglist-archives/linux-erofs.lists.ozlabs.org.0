Return-Path: <linux-erofs+bounces-1470-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD28C97BBE
	for <lists+linux-erofs@lfdr.de>; Mon, 01 Dec 2025 14:54:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dKll40MpGz2ynC;
	Tue, 02 Dec 2025 00:54:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764597279;
	cv=none; b=hErtioI+67gPcEmx+cmFOG2orZfYamz6rJ+HtnMF/7E7228Av2C++IvHFc/YUH0s7eJJcu1jmLZiecOyrWMYoZLZ8PXAzi8neMGniXk+V9duz7c6hQj2BEDyu5XH8mf6YpWg10JbOuk1n/HihFWLQyREA74HvrbrzQTOip9Ie2QKpB0mrgQ9PdAJPPY9OsGiStzWs05Gil6IH6xFFxgnw74kW/j0QrhrXQ6kR1vUxQhU6by0lYKGbmW+20MCynZtph9pMkXnC2f8NnHoMQY7FGPnPLuoXjNYdEeC3OvLaST0EPC3OUwoqMHCaCLqUxtKGkDsPdP2KkOUGTcaoC4kjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764597279; c=relaxed/relaxed;
	bh=jIpCx/UzENqw/NKwz0ctWSHWYucNFXIvWjap00njcnQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:CC:
	 References:From:In-Reply-To; b=n6rUndNOKt1uaEemMZYHAEqCXoz/c/5kjJ81YV0VROxCTTnHlXKAmrSQ92szNaVMbHfoDQyBO7wl0tAUKff/wbOHdggXeGCzZOT65gGZgNnYrY0km/vBRq3J/LlRPjgDf1SdwKk6NFGY4/NqwBKwrILLGqqsWrfJrvuQr1gx4IMgr06uJ8vpm7D0n+MYAzFj4bDpcdUgKLST36vurwAz4kc5Ei+TjwggdDIteBuzoBk0mB0KY4YtAdmEOEJCRA04Y0xbgvVGIzEw4bH0sYfSmu70XTHhe3BFMoeUusXWjmTIJTqUca6Bxm9CJtbnTzCveo15DYiQKN+NecPDoPaRIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=iSfjZpsh; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=iSfjZpsh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dKll00CThz2yqP
	for <linux-erofs@lists.ozlabs.org>; Tue, 02 Dec 2025 00:54:33 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jIpCx/UzENqw/NKwz0ctWSHWYucNFXIvWjap00njcnQ=;
	b=iSfjZpshmfyAFPRqytDuoPzZszsiVhlAeNr2xgHrtnSbEPYQL+rGSrgv3kPJAV+kSu8VScES7
	fxJxvehyF+N4De/nK7tVB+yFLN3O7jY96dL3/Br8gRexAzDVpRY6K7lLDOZSFpN0fCFlCWoWRbk
	UeGgv/iG8xb/C/e9uW52ztM=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dKlhg73dtzRhQw;
	Mon,  1 Dec 2025 21:52:35 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 379801402ED;
	Mon,  1 Dec 2025 21:54:27 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 1 Dec 2025 21:54:26 +0800
Content-Type: multipart/alternative;
	boundary="------------gldoKLftK2X8nWOE0b8IHn0u"
Message-ID: <204548c7-3c09-4e05-aa44-9abf00f4009d@huawei.com>
Date: Mon, 1 Dec 2025 21:54:26 +0800
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
Subject: Re: [PATCH v1] erofs-utils: mount: add manpage and usage information
To: ChengyuZhu6 <hudson@cyzhu.com>, <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, Chengyu Zhu <hudsonzhu@tencent.com>
References: <20251130033516.86065-1-hudson@cyzhu.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <20251130033516.86065-1-hudson@cyzhu.com>
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--------------gldoKLftK2X8nWOE0b8IHn0u
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 2025/11/30 11:35, ChengyuZhu6 wrote:
> +static void usage(int argc, char **argv)
> +{
> +	printf("Usage: %s [OPTIONS] SOURCE [MOUNTPOINT]\n"
> +	       "Manage EROFS filesystem.\n"
> +	       "\n"
> +	       "General options:\n"
> +	       " -V, --version         print the version number of mount.erofs and exit\n"
> +	       " -h, --help            display this help and exit\n"
> +	       " -o options            comma-separated list of mount options\n"
> +	       " -t type[.subtype]     filesystem type (and optional subtype)\n"
> +	       "                       subtypes: fuse, local, nbd\n"
> +	       " -u                    unmount the filesystem\n"
> +	       "    --reattach         reattach to an existing NBD device\n"

Hi Chengyu,

Seems wrong indent here.


Thanks,
Yifan Zhao


> +#ifdef OCIEROFS_ENABLED
>
--------------gldoKLftK2X8nWOE0b8IHn0u
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025/11/30 11:35, ChengyuZhu6 wrote:<span
      style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite"
      cite="mid:20251130033516.86065-1-hudson@cyzhu.com">
      <pre wrap="" class="moz-quote-pre">+static void usage(int argc, char **argv)
+{
+	printf("Usage: %s [OPTIONS] SOURCE [MOUNTPOINT]\n"
+	       "Manage EROFS filesystem.\n"
+	       "\n"
+	       "General options:\n"
+	       " -V, --version         print the version number of mount.erofs and exit\n"
+	       " -h, --help            display this help and exit\n"
+	       " -o options            comma-separated list of mount options\n"
+	       " -t type[.subtype]     filesystem type (and optional subtype)\n"
+	       "                       subtypes: fuse, local, nbd\n"
+	       " -u                    unmount the filesystem\n"
+	       "    --reattach         reattach to an existing NBD device\n"</pre>
    </blockquote>
    <p>Hi Chengyu,</p>
    <p>Seems wrong indent here.</p>
    <p><br>
    </p>
    <p>Thanks,<br>
      Yifan Zhao</p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:20251130033516.86065-1-hudson@cyzhu.com">
      <pre wrap="" class="moz-quote-pre">
+#ifdef OCIEROFS_ENABLED

</pre>
    </blockquote>
  </body>
</html>

--------------gldoKLftK2X8nWOE0b8IHn0u--


Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B3054A98B
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jun 2022 08:35:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LMdwF44MBz3cgF
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jun 2022 16:35:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=7Hz1hDej;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=7Hz1hDej;
	dkim-atps=neutral
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LMdvm5sPfz3cBk
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Jun 2022 16:34:43 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id f65so7657071pgc.7
        for <linux-erofs@lists.ozlabs.org>; Mon, 13 Jun 2022 23:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:references:to
         :cc:in-reply-to:content-transfer-encoding;
        bh=+jAhLK+0fRHMqQ7qoZz//CDul2lnBSp2wfTG4W3TRQY=;
        b=7Hz1hDej1YfISAhj2ghxc0GuGt9PuotmojKTh/wg//kRhsnoNxfc9Gp9LvFaBQPI0l
         YHKYhqJvGpQpbYuFf9Ot1cur89S3jnDDzRI5DBjedkjHjsxNYgtH1eED7YmCgftrJ3/R
         lELB83OmKsKTdtDVTgOjLQD9ASREJCYAHZYj1nfJXZnnny2BNlZmQ2/jf/nEUBJIuc8R
         tjYhQdvSg59dBQnJ4lkLON1lW8OrnrmDJZRFwGG7PJIqo6h0fXrx/8ZIdFd5MlOmkpYQ
         0nJ+isjUBxgLmbtEB4FvTMylSj8e/xsxS4HApXUbKCp6bpAtKgUPUHgwmFuztn90L/DM
         vCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:references:to:cc:in-reply-to:content-transfer-encoding;
        bh=+jAhLK+0fRHMqQ7qoZz//CDul2lnBSp2wfTG4W3TRQY=;
        b=5bdowuAgnGkvWVObvZiB9XM03OAIvkhFD4+/Emw0Z5qZmefib2QI2+pma5ioyrmZ5I
         9qi/Mc8kuh9XlwEhj01ZicIGe9tSDI8PZFVVDlIgn8Y1GvoTMsxYCQvMKTEFjDp4oW7H
         KXfVLe48pgVSi66g1/kJAmOprrSkNGbZgnKQpjaQoApmasNh2xSzZDySBoxq+MYM2CMh
         sTKYddwYj6ZYGGn4GYKJfsEggTbc9vW75UsiABna2qwgntxWjfm6EX6YadLTIbez6dr/
         oFmC92zMZrTNDOFe2MiJ97wWpP21r3w6yNug0jMPAQi703BgqvOtXYkgPpUMlTDAOWTE
         003A==
X-Gm-Message-State: AOAM533KLqD0L7UyCWoTt2/fHyOu2SY6Smr77z33uTC1G0eHHeiuf1Zs
	pb91Zf25QhGCiKqLnOg8gZ5yvg==
X-Google-Smtp-Source: ABdhPJwI8ptLculCXHH09zaUTB4/GIyuPN6zhr0t2oVTtpjjxCMh96Fh9i44Mib1GeyNhURAH8gs1Q==
X-Received: by 2002:a05:6a00:a21:b0:522:9134:c620 with SMTP id p33-20020a056a000a2100b005229134c620mr2891196pfh.68.1655188480394;
        Mon, 13 Jun 2022 23:34:40 -0700 (PDT)
Received: from [10.4.226.233] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id x16-20020a1709027c1000b0015e8d4eb276sm6277288pll.192.2022.06.13.23.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 23:34:40 -0700 (PDT)
Message-ID: <0ccf0d41-f080-5dde-6afb-5957e2d92a39@bytedance.com>
Date: Tue, 14 Jun 2022 14:34:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
From: Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH 0/1] cachefiles: Add a command to restore on-demand requests
References: <98ac6b1a-1c63-65ab-d315-7a1e38cef46f@bytedance.com>
To: dhowells@redhat.com, Jeffle Xu <jefflexu@linux.alibaba.com>,
 xiang@kernel.org
In-Reply-To: <98ac6b1a-1c63-65ab-d315-7a1e38cef46f@bytedance.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David, Jeffle & Xiang

In production environment, process crashes sometimes occurs.

In cachefiles on-demand read scenario, if user daemon crashes,
requests will return -EIO.
User programs which do not consider this error will trap into
uncertain state.

Based on this, we came up with a user daemon crash recover scheme.
Even if user daemon crashes, the device connection and anonymous fd
will not be released. Recovered user daemon only needs to write 'restore'
to /dev/cachefiles to restore in-flight requests.

Userspace Crash Recover Demo (Based on Jeffle's User Demo)
--------------------------
Git tree:
	https://github.com/userzj/demand-read-cachefilesd.git main
Gitweb:
	https://github.com/userzj/demand-read-cachefilesd

Jia Zhu (1):
   cachefiles: Add a command to restore on-demand requests

  fs/cachefiles/daemon.c   |  1 +
  fs/cachefiles/internal.h |  3 +++
  fs/cachefiles/ondemand.c | 25 +++++++++++++++++++++++++
  3 files changed, 29 insertions(+)

-- 
2.20.1

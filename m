Return-Path: <linux-erofs+bounces-1853-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331B6D1CF9A
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jan 2026 08:59:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drdmX5TyZz2xPB;
	Wed, 14 Jan 2026 18:59:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768377548;
	cv=none; b=QD5cdyjy6I2MDDs1a6BZSVCqqNlrTueidrAO1BxRKOf64X+ti5Gtr9rGKCcYT9e51eeNaOLjfKuog8ZwzVrDqp2zsBkgSud+5XPe4nd2PEESbY4cUFgLxcYfNosLGed3QLUf/YUTox667D/v7LQTJAfMU4j9x2OhWlXNO9t2QIObbW5k9jtDPh5KCFT60Rd/oZKIVN4CKB21hgBRXjKWZHcga5aeze9S0DzKSZBJBWn8MjPsimKS7QzZ+wxAywqvpf7lPwUwRmJGLjRyEjzN0mo10ZnGy/naX75JC+1gUPmceuVdfBEz+hynm6ZnnpWZdz5zKPxYxs+WXktwdk81rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768377548; c=relaxed/relaxed;
	bh=ckbbp+pasBoimgr6/EUtnVNVERfRk64V5UUIih8RTKg=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:CC:
	 References:From:In-Reply-To; b=YOij10A+rpsWQrFtNgCuXbqF69TNhW8bvXYevPOo9jQwX3mah9vPf3NymNz2vbXkUC8zmH7hhs6S/dMHLcROJ1DNEqoyxwRkk42KE45EHYzSfxo3H3L4/odgo5hTZRgsrSVoPWcjiml9YnCnrOZILZMKPfLSlrhQRwa+9wBitrLW4TO446oCc/9MGv8OF9Z67zSoKOyzv0ctsHP/Lm7xo7QMJ6imbpXBE3aY9ZuFsF9E45sN7pbALoY9vybq7A0hS/GioYFLn+3TR9LrpwKzVHJhZ3G4KfcVmv3Gqyko6oP2un2eG0mffTYng5NNxHmoVeI6d0e/dwFCPixXK/DipA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=NHbSKj7Z; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=NHbSKj7Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drdmV0Hgpz2xFn
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Jan 2026 18:59:03 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ckbbp+pasBoimgr6/EUtnVNVERfRk64V5UUIih8RTKg=;
	b=NHbSKj7ZF03r99NY0BTiLqeq7N2LcGSyRm462BxvGE/y+58VX99V0aqbuRg+0OYO57whw7cx5
	4f+J8vD1BVQ/56EGXQWUWeCRmrcgVOjX5ePH8U928Iuh/2v3bx7muSsjo4X5u9JdOOUi9lim9sE
	xH5W6+LoEdRMCnACanYA+bI=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4drdhV26CgzKm5f;
	Wed, 14 Jan 2026 15:55:38 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 81A5740563;
	Wed, 14 Jan 2026 15:58:58 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 14 Jan 2026 15:58:58 +0800
Content-Type: multipart/alternative;
	boundary="------------I6S0VEOLGmIqhu77mM0PGdEP"
Message-ID: <0bc1baff-775b-4cf7-89f8-eaa22af10d9f@huawei.com>
Date: Wed, 14 Jan 2026 15:58:57 +0800
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
Subject: Re: [PATCH v2] erofs-utils: lib: correctly set {u,g}id in
 erofs_rebuild_make_root()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>
References: <7db44e77-9256-469d-9845-d40079ab2a5a@linux.alibaba.com>
 <20260114073806.3640681-1-zhaoyifan28@huawei.com>
 <1e1c7c27-abb5-4f6a-b27c-0f15b9e5da16@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <1e1c7c27-abb5-4f6a-b27c-0f15b9e5da16@linux.alibaba.com>
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--------------I6S0VEOLGmIqhu77mM0PGdEP
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/1/14 15:44, Gao Xiang wrote:

> we could support !im, I mean
>
>     struct erofs_importer_params *params = im ? im->params : NULL;

Hi Xiang,

Do we have any chance `im == NULL` in current codebase? Or is it to 
allow for future extensibility?

>
>>       struct erofs_inode *root;
>>   @@ -2384,6 +2385,8 @@ struct erofs_inode 
>> *erofs_rebuild_make_root(struct erofs_sb_info *sbi)
>>           return root;
>>       root->i_srcpath = strdup("/");
>>       root->i_mode = S_IFDIR | 0777;
>> +    root->i_uid = im->params->fixed_uid == -1 ? getuid() : 
>> im->params->fixed_uid;
>> +    root->i_gid = im->params->fixed_gid == -1 ? getgid() : 
>> im->params->fixed_gid;
>
>
>
>     root->i_uid = params && params->fixed_uid < 0 ? getuid() :
>             params->fixed_uid;

will sigfault if `params == NULL`, how about

     root->i_uid = (!params || params->fixed_uid < 0) ? getuid() :
                                params->fixed_uid;


Thanks,

Yifan

> ... 
--------------I6S0VEOLGmIqhu77mM0PGdEP
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>On 2026/1/14 15:44, Gao Xiang wrote:</p>
    <blockquote type="cite"
      cite="mid:1e1c7c27-abb5-4f6a-b27c-0f15b9e5da16@linux.alibaba.com">we
      could support !im, I mean
      <br>
      <br>
          struct erofs_importer_params *params = im ? im-&gt;params :
      NULL; <br>
    </blockquote>
    <p>Hi Xiang,</p>
    <p>Do we have any chance `im == NULL` in current codebase? Or is it
      to allow for future extensibility?</p>
    <blockquote type="cite"
      cite="mid:1e1c7c27-abb5-4f6a-b27c-0f15b9e5da16@linux.alibaba.com"><br>
      <blockquote type="cite" style="color: #007cff;">      struct
        erofs_inode *root;
        <br>
          @@ -2384,6 +2385,8 @@ struct erofs_inode
        *erofs_rebuild_make_root(struct erofs_sb_info *sbi)
        <br>
                  return root;
        <br>
              root-&gt;i_srcpath = strdup("/");
        <br>
              root-&gt;i_mode = S_IFDIR | 0777;
        <br>
        +    root-&gt;i_uid = im-&gt;params-&gt;fixed_uid == -1 ?
        getuid() : im-&gt;params-&gt;fixed_uid;
        <br>
        +    root-&gt;i_gid = im-&gt;params-&gt;fixed_gid == -1 ?
        getgid() : im-&gt;params-&gt;fixed_gid;
        <br>
      </blockquote>
      <br>
      <br>
      <br>
          root-&gt;i_uid = params &amp;&amp; params-&gt;fixed_uid &lt; 0
      ? getuid() :
      <br>
                  params-&gt;fixed_uid; <br>
    </blockquote>
    <p>will sigfault if `params == NULL`, how about</p>
    <p>    root-&gt;i_uid = (!params || params-&gt;fixed_uid &lt; 0) ?
      getuid() :<br>
                                     params-&gt;fixed_uid;</p>
    <p><br>
    </p>
    <p>Thanks,</p>
    <p>Yifan</p>
    <blockquote type="cite"
      cite="mid:1e1c7c27-abb5-4f6a-b27c-0f15b9e5da16@linux.alibaba.com">...
    </blockquote>
  </body>
</html>

--------------I6S0VEOLGmIqhu77mM0PGdEP--


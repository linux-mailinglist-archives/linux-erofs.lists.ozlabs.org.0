Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3155644A54E
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 04:23:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpCxF0kdRz2yQH
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 14:23:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=perches.com
 (client-ip=216.40.44.176; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
X-Greylist: delayed 541 seconds by postgrey-1.36 at boromir;
 Tue, 09 Nov 2021 14:23:21 AEDT
Received: from smtprelay.hostedemail.com (smtprelay0176.hostedemail.com
 [216.40.44.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpCx53wwQz2xrP
 for <linux-erofs@lists.ozlabs.org>; Tue,  9 Nov 2021 14:23:19 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 984B41836943D
 for <linux-erofs@lists.ozlabs.org>; Tue,  9 Nov 2021 03:14:20 +0000 (UTC)
Received: from omf20.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8B43F1829B8FD;
 Tue,  9 Nov 2021 03:14:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf20.hostedemail.com (Postfix) with ESMTPA id 5E4A218A60C; 
 Tue,  9 Nov 2021 03:14:14 +0000 (UTC)
Message-ID: <cc9807eb594b042ec2cd958f0c70c2f3dd12d58b.camel@perches.com>
Subject: Re: [PATCH 1/2] erofs: add sysfs interface
From: Joe Perches <joe@perches.com>
To: Huang Jianan <huangjianan@oppo.com>, linux-erofs@lists.ozlabs.org
Date: Mon, 08 Nov 2021 19:14:13 -0800
In-Reply-To: <20211109025445.12427-1-huangjianan@oppo.com>
References: <20211109025445.12427-1-huangjianan@oppo.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5E4A218A60C
X-Spam-Status: No, score=-4.15
X-Stat-Signature: 4k1qequtneuzwq7efx34abfoa48qjm1y
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19tC8M+OVunKUJInFptKz4De5mCUJw4EP8=
X-HE-Tag: 1636427654-852723
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
Cc: yh@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com, guanyuwei@oppo.com,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 2021-11-09 at 10:54 +0800, Huang Jianan wrote:
> Add sysfs interface to configure erofs related parameters in the
> future.
[]
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
[]
> +static ssize_t erofs_attr_show(struct kobject *kobj,
> +				struct attribute *attr, char *buf)
> +{
> +	struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
> +						s_kobj);
> +	struct erofs_attr *a = container_of(attr, struct erofs_attr, attr);
> +	unsigned char *ptr = __struct_ptr(sbi, a->struct_type, a->offset);
> +
> +	switch (a->attr_id) {
> +	case attr_feature:
> +		return snprintf(buf, PAGE_SIZE, "supported\n");
> +	case attr_pointer_ui:
> +		if (!ptr)
> +			return 0;
> +		return snprintf(buf, PAGE_SIZE, "%u\n",
> +				*((unsigned int *) ptr));

Prefer sysfs_emit over snprintf

	case attr_feature:
		return sysfs_emit(buf, "supported\n");
	case attr_pointer_ui:
		...
		return sysfs_emit(buf, "%u\n", *(unsigned int *)ptr);

etc...



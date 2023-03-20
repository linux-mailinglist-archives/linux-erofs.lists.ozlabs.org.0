Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 278736C0B55
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Mar 2023 08:27:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pg5sq3YcQz3cCy
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Mar 2023 18:27:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1679297247;
	bh=FNnp65p18r9InImb3TefnHBuhcbVhzynIwAJbR29uJY=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Vy5hPVvLmEs9/wqXlqbbOb6hwfhYFCpu4zBULHfrLWee10L7AJOa4afR7ppCxb/67
	 rw9I2F4ES7RS//cGfJFm/Gs3wKDTDeBScfsFTpfBhnbmh7gUE1k8SwiN47VIYlZtSC
	 WpVS1JRwVprfXGxNe4hbyuxh0lwOnrzmAbMgVKmdb7ZXbg7+9omSyspKQi1vPGmtQq
	 3SqZBQ1wFB5GmAMcL878AVzuxRXb6AudEfbDEhjeOLAsBGYhqwDSrq/HlmdVwHl7ov
	 +Fqts6+rAxPFiti7dCNK/jdyuiqOQ+vfyiNnuKmlK+lkZB5VCd5mqsXmRuh9zgKe3t
	 U/FkFNtMGJUkQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=opensource.wdc.com (client-ip=68.232.141.245; helo=esa1.hgst.iphmx.com; envelope-from=prvs=436eb87b3=damien.lemoal@opensource.wdc.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=OSXHWyU7;
	dkim=pass (2048-bit key; unprotected) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.a=rsa-sha256 header.s=dkim header.b=Ac3sR0XY;
	dkim-atps=neutral
X-Greylist: delayed 64 seconds by postgrey-1.36 at boromir; Mon, 20 Mar 2023 18:27:19 AEDT
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pg5sg0rXQz3bVP
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Mar 2023 18:27:18 +1100 (AEDT)
X-IronPort-AV: E=Sophos;i="5.98,274,1673884800"; 
   d="scan'208";a="338068386"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2023 15:26:11 +0800
IronPort-SDR: grpFpuntzHkMoZmwkoDRnvnqQyVNEKjUF2hAT2hix9dacja6nOVJCddJv4dI3uwiOqOSsKgr6q
 vH4WVtTvLOjgm8zHQqoCZ2KTXtPcw6t/nT93S2gePS5sdyhDDV12Zk8axP8Y/WTsv+rgzBSYtC
 UO4jXIBAfnA6bVpChPFb5OvndFe3A5wES6xRQqh3EWvbqbPqkTrEFSKf/c+wWNZ8CgnpGG9MQl
 Vt2O5h+Lgk2NWEtyPDksrsWR7lgpIxgvXQyrVvLN3gjDRkmVinxMte+wdBBOHQlY9NvWAw8Ku3
 p0I=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2023 23:36:51 -0700
IronPort-SDR: fFAMe2JCfMVDk/xKBoEV7v1brtyb8OhX02zxcgAqQZpqAgFcO5pu5FffMecrq5PkphMtp+FNUh
 XvV9FDSBcDub00oly3zsjdTAvrezI+e0uQhJxlB7OjhwO0nl6Nyhy9G2/9RD08+NeZG3dkBsHP
 +xQVLEEQ1XO/f5uwIki0HGORmBSoCUFv9tFLgCW99j43ZEgGfEvJHeP5v8r/ZtMwo9Go6gJvpR
 FawHaMQYNDLpEss4h/3c3Wqmyiwxvd7oIv6AZtdjEsdpaOCdqNnjbDVWOFPP38zdCuQ6r9hHLh
 BvY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Mar 2023 00:26:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pg5rL1Rc3z1RtW1
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Mar 2023 00:26:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Q3owblN1hOvg for <linux-erofs@lists.ozlabs.org>;
	Mon, 20 Mar 2023 00:26:09 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pg5rB164vz1RtVm;
	Mon, 20 Mar 2023 00:26:01 -0700 (PDT)
Message-ID: <982b6aa9-4adb-acef-d9d7-9a1764a66213@opensource.wdc.com>
Date: Mon, 20 Mar 2023 16:26:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2, RESEND 01/10] kobject: introduce kobject_del_and_put()
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
 jefflexu@linux.alibaba.com, jaegeuk@kernel.org,
 trond.myklebust@hammerspace.com, anna@kernel.org, konishi.ryusuke@gmail.com,
 mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
 richard@nod.at, djwong@kernel.org, naohiro.aota@wdc.com, jth@kernel.org,
 gregkh@linuxfoundation.org, rafael@kernel.org
References: <e4b8012d-32df-e054-4a2a-772fda228a6a@opensource.wdc.com>
 <20230320071140.44748-1-frank.li@vivo.com>
Organization: Western Digital Research
In-Reply-To: <20230320071140.44748-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
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
From: Damien Le Moal via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 3/20/23 16:11, Yangtao Li wrote:
> Hi filesystem maintainers,
> 
>> Hard to comment on patches with this. It is only 10 patches. So send everything please.
> 
> If you are interested in the entire patchset besides Damien,
> please let me know. I'll resend the email later to cc more people.

Yes, I said I am interested, twice already. It is IMPOSSIBLE to review a patch
without the context of other patches before/after said patch. So if you want a
review/ack for zonefs, then send the entire series.

> 
> Thx,
> Yangtao

-- 
Damien Le Moal
Western Digital Research


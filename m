Return-Path: <linux-erofs+bounces-1520-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A261CCF321
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Dec 2025 10:47:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dXjPL3Y75z2yFW;
	Fri, 19 Dec 2025 20:47:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.254.224.34
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766137638;
	cv=none; b=lZnzpix59v9i27xT9/fDDRt+Ld6FvaNApeFcGQoFRCJo9c0mFcWeZ30CzR8nv7q6cGRpqdUh5Lpf4BH5tc7OasezHIsUC81+6U99CDNjgKKccu4PjptOEa8NOaDx5EPm/Rfg8XfUDGG3iwr+noe3WOfU8Fhbpxzvf/WFJU7l0V/oMe1JKyLzTZZWfBswngy8ATjyaagfFf1qwhunLIxF9MizJL6AS08qW4FSkNqRnTfYfyx/tqVtnt0V2nM87cUMlDqtJEHXXdjXJxb82gK6gdoqGzNB/fQ/1TQoXCBmKxmWPvQyZWUmXtrZUaLpalW/KsIfHLM3rTThniDkDw2Wuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766137638; c=relaxed/relaxed;
	bh=5NTyHC//MBd7D9ijLQKV44JJ85QmkJb66DX6ik8hBo8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=fpChhYx9MC3lLuYfBGv2ysZSSXHwlsCMqfGaIPdY0w8ickj2SzXwtULBWID45ZS2Nm7L5nD3WFJVrLcAjXV4JFYc3OTkfzq8AXqaX5S+w6BT2VcoKF3g/irYNQPWi6vjRnuGlIi+Ipx9zE541NgcIIHF3OrScplOTiR5uN/2HqHatOzLAMyRTZpO/Y07rDupRQpLzhRezW34osQ4XDbVwO0kVPCIynby0OYir7rx1PMCp5rLgNsG/XfZpnmW680sUOLdZEkVQwqyVYzv1jcllS6Q9waWlCsP+TCM6tdo6o7hBr9cemhRRs18Tni+AIXP4oXhGVVu5wePgmPk+FWVNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Hdtr44RG; dkim-atps=neutral; spf=pass (client-ip=203.254.224.34; helo=mailout4.samsung.com; envelope-from=junbeom.yeom@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Hdtr44RG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=203.254.224.34; helo=mailout4.samsung.com; envelope-from=junbeom.yeom@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXjPH3yfzz2xqm
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Dec 2025 20:47:13 +1100 (AEDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251219094702epoutp04ed9de0645dd0fed5c638ef8c521c6602~ClM_GGBee2785827858epoutp04Y
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Dec 2025 09:47:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251219094702epoutp04ed9de0645dd0fed5c638ef8c521c6602~ClM_GGBee2785827858epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1766137622;
	bh=5NTyHC//MBd7D9ijLQKV44JJ85QmkJb66DX6ik8hBo8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=Hdtr44RGneFeDnVlEkKYN5oZRa3FyCFUh/U8I753wS/tU91r6pBuJfIDqtrEXK/l1
	 XTazeVdY/TH8YLl/JsNc2Gmo6WfVj3Gj+SyI9um2Cnq/NqyJGOZ5ywL03wJS92nmx9
	 fYZRATdTYOg52urZvWChWWZkiXdnFTbal03qHwCg=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
	20251219094702epcas1p1fe96c7eb9cee5124f4f0d995e0e0468c~ClM9xIfQv0732307323epcas1p1J;
	Fri, 19 Dec 2025 09:47:02 +0000 (GMT)
Received: from epcas1p4.samsung.com (unknown [182.195.38.194]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dXjP22Mdwz6B9m7; Fri, 19 Dec
	2025 09:47:02 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20251219094701epcas1p37f0febda668d0f243aae2cfd3110f51a~ClM8_2oq33127331273epcas1p3p;
	Fri, 19 Dec 2025 09:47:01 +0000 (GMT)
Received: from junbeomyeom03 (unknown [10.246.23.239]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251219094701epsmtip15e8aeea997098f5807c613bdedecbe5f~ClM8xjpEN1850018500epsmtip1H;
	Fri, 19 Dec 2025 09:47:01 +0000 (GMT)
From: "Junbeom Yeom" <junbeom.yeom@samsung.com>
To: "'Gao Xiang'" <hsiangkao@linux.alibaba.com>, <xiang@kernel.org>,
	<chao@kernel.org>
Cc: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, "'Jaewook Kim'" <jw5454.kim@samsung.com>,
	"'Sungjong Seo'" <sj1557.seo@samsung.com>
In-Reply-To: <6a9737d3-1ecd-4105-ad8d-8379cb35bfc7@linux.alibaba.com>
Subject: RE: [PATCH] erofs: fix unexpected EIO under memory pressure
Date: Fri, 19 Dec 2025 18:47:01 +0900
Message-ID: <000001dc70cc$6cc150c0$4643f240$@samsung.com>
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
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKJQSbFteedIs8/ccFsZ8lv+FLO8QLYU4qmAjUmpUOzpqlOQA==
Content-Language: ko
X-CMS-MailID: 20251219094701epcas1p37f0febda668d0f243aae2cfd3110f51a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251219071140epcas1p35856372483a973806c5445fa3d2d260b
References: <CGME20251219071140epcas1p35856372483a973806c5445fa3d2d260b@epcas1p3.samsung.com>
	<20251219071034.2399153-1-junbeom.yeom@samsung.com>
	<6a9737d3-1ecd-4105-ad8d-8379cb35bfc7@linux.alibaba.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Xiang,

>
> Hi Junbeom,
>
> On 2025/12/19 15:10, Junbeom Yeom wrote:
>> erofs readahead could fail with ENOMEM under the memory pressure
>> because it tries to alloc_page with GFP_NOWAIT =7C GFP_NORETRY, while
>> GFP_KERNEL for a regular read. And if readahead fails (with
>> non-uptodate folios), the original request will then fall back to
>> synchronous read, and =60.read_folio()=60 should return appropriate errn=
os.
>>
>> However, in scenarios where readahead and read operations compete,
>> read operation could return an unintended EIO because of an incorrect
>> error propagation.
>>
>> To resolve this, this patch modifies the behavior so that, when the
>> PCL is for read(which means pcl.besteffort is true), it attempts
>> actual decompression instead of propagating the privios error except ini=
tial EIO.
>>
>> - Page size: 4K
>> - The original size of FileA: 16K
>> - Compress-ratio per PCL: 50% (Uncompressed 8K -> Compressed 4K)
>> =5Bpage0, page1=5D =5Bpage2, page3=5D =5BPCL0=5D---------=5BPCL1=5D
>>
>> - functions declaration:
>>    . pread(fd, buf, count, offset)
>>    . readahead(fd, offset, count)
>> - Thread A tries to read the last 4K
>> - Thread B tries to do readahead 8K from 4K
>> - RA, besteffort =3D=3D false
>> - R, besteffort =3D=3D true
>>
>>          <process A>                   <process B>
>>
>> pread(FileA, buf, 4K, 12K)
>>    do readahead(page3) // failed with ENOMEM
>>    wait_lock(page3)
>>      if (=21uptodate(page3))
>>        goto do_read
>>                                 readahead(FileA, 4K, 8K)
>>                                 // Here create PCL-chain like below:
>>                                 // =5Bnull, page1=5D =5Bpage2, null=5D
>>                                 //   =5BPCL0:RA=5D-----=5BPCL1:RA=5D
>> ...
>>    do read(page3)        // found =5BPCL1:RA=5D and add page3 into it,
>>                          // and then, change PCL1 from RA to R ...
>>                                 // Now, PCL-chain is as below:
>>                                 // =5Bnull, page1=5D =5Bpage2, page3=5D
>>                                 //   =5BPCL0:RA=5D-----=5BPCL1:R=5D
>>
>>                                   // try to decompress PCL-chain...
>>                                   z_erofs_decompress_queue
>>                                     err =3D 0;
>>
>>                                     // failed with ENOMEM, so page 1
>>                                     // only for RA will not be uptodated=
.
>>                                     // it's okay.
>>                                     err =3D decompress(=5BPCL0:RA=5D, er=
r)
>>
>>                                     // However, ENOMEM propagated to nex=
t
>>                                     // PCL, even though PCL is not only
>>                                     // for RA but also for R. As a resul=
t,
>>                                     // it just failed with ENOMEM withou=
t
>>                                     // trying any decompression, so page=
2
>>                                     // and page3 will not be uptodated.
>>                  ** BUG HERE ** --> err =3D decompress(=5BPCL1:R=5D, err=
)
>>
>>                                     return err as ENOMEM ...
>>      wait_lock(page3)
>>        if (=21uptodate(page3))
>>          return EIO      <-- Return an unexpected EIO=21
>> ...
>
> Many thanks for the report=21
> It's indeed a new issue to me.
>
>>
>> Fixes: 2349d2fa02db (=22erofs: sunset unneeded NOFAILs=22)
>> Cc: stable=40vger.kernel.org
>> Reviewed-by: Jaewook Kim <jw5454.kim=40samsung.com>
>> Reviewed-by: Sungjong Seo <sj1557.seo=40samsung.com>
>> Signed-off-by: Junbeom Yeom <junbeom.yeom=40samsung.com>
>> ---
>>   fs/erofs/zdata.c =7C 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c index
>> 27b1f44d10ce..86bf6e087d34 100644
>> --- a/fs/erofs/zdata.c
>> +++ b/fs/erofs/zdata.c
>> =40=40 -1414,11 +1414,15 =40=40 static int z_erofs_decompress_queue(cons=
t struct
>z_erofs_decompressqueue *io,
>>   	=7D;
>>   	struct z_erofs_pcluster *next;
>>   	int err =3D io->eio ? -EIO : 0;
>> +	int io_err =3D err;
>>
>>   	for (; be.pcl =21=3D Z_EROFS_PCLUSTER_TAIL; be.pcl =3D next) =7B
>> +		int propagate_err;
>> +
>>   		DBG_BUGON(=21be.pcl);
>>   		next =3D READ_ONCE(be.pcl->next);
>> -		err =3D z_erofs_decompress_pcluster(&be, err) ?: err;
>> +		propagate_err =3D READ_ONCE(be.pcl->besteffort) ? io_err : err;
>> +		err =3D z_erofs_decompress_pcluster(&be, propagate_err) ?: err;
>
> I wonder if it's just possible to decompress each pcluster according to i=
o
> status only (but don't bother with previous pcluster status), like:
>
> 		err =3D z_erofs_decompress_pcluster(&be, io->eio) ?: err;
>
> and change the second argument of
> z_erofs_decompress_pcluster() to bool.
>
> So that we could leverage the successful i/o as much as possible.

Oh, I thought you were intending to address error propagation.
If that's not the case, I also believe the approach you're suggesting is be=
tter.
I'll send the next version.

Thanks,
Junbeom Yeom

>
> Thanks,
> Gao Xiang
>
>>   	=7D
>>   	return err;
>>   =7D
>




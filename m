Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9400510DC25
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Nov 2019 03:13:33 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Pw0B5ZTzzDrDF
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Nov 2019 13:13:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1575080010;
	bh=VBMEi3vnzgFFJii6Egz4jAIv728J2n19vO76brLUAPw=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=nZZXFxqYXBINfz61pb8Nc3prwUiPJv3uaorz2qRGmloJPbgBlxQX7kjudFO4Zoe3N
	 53FwgXUSI/mCNvTqdTCqkJ2dPWAPvsN6Wz6E1K8ne3PARgeJRMT3Om9oC2S8Kodzh8
	 ntKFqjXxYHCmyUrigWnRFltyel7bx3VLkYrn8wkOacQRDZEZVVHJPlBQP4pZ+YUCve
	 GQDPp+s0Og/T95QMId9lISBbUrzHDfalvfpmY5ZjsEdxfRhf/0spao88bL8DyxLpeW
	 OFylQet23U4AHceeDZ5yG2tM4yiLyuEreNRvjWe7s/l+jxiE0dXY8YVixoQLmCcjIC
	 EADvw4UCT5IMA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.31; helo=sonic316-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="fGBs4IPV"; 
 dkim-atps=neutral
Received: from sonic316-55.consmr.mail.gq1.yahoo.com
 (sonic316-55.consmr.mail.gq1.yahoo.com [98.137.69.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Pw002llKzDqCV
 for <linux-erofs@lists.ozlabs.org>; Sat, 30 Nov 2019 13:13:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1575079995; bh=iytEh24ZU3TS0cV8jzx8tCOHWf4jvxf9DH4Gr4yJ/lk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=fGBs4IPVDzQNCQg95kXS7FzaQeekN1LG/GnGlQ0lmHRGIFgTmYZCraBvDb31QrMZ/iBGVuLqWdPXf2MpUddHcEqc03zzOjK5kLaLcYZSP6R3meKxoNDBwdZCzMotmxEuO+gNWTUmRvbSHp+7vXYK+lP4ruOV1o5iot8gyKOfJ7h8YolNsFuYnhRvrWT5YdiORxdojEiswNdkphCeXltO89a1/RaZJWDE1+/wec6jF8aqR/0sS73w6utrn6c/HlbiqPiler0Eq2/BnjPMQPQgwbj5pt/4oltl9Cn+BKfbGgLXIZWJAY2GuOYC7cD0nNXWHbDmnn4ovNWu9uZEe4Q6rQ==
X-YMail-OSG: Z.IHe9YVM1mofGXJE2VClsqwrAFvGpqlhMBLGpa83naKcRrhIhdo.UxEYkD5W8C
 NQEoHoLWSzGNOfj9b.XunNvKD7QH9zd_mxpW7Qz075CYK8LFl4ELrHIzxGFnWBIH99aSUjeHDOJi
 GoQee72uamo0ukX5wm3A2XKV.5gU7Q3yIIQ2edA9cs1zdnALJM3p7OUAQ8Mkqf4ak8BQORagIHzu
 O__b1zGwjcTZtxaRH_U.n5dIhMrsjqx21EIl5QZ82KFcB1ehIvh3RjVhdcvAGv8pa6NG_vKsqW97
 2le9Sw2FYLXvhMpZQNitSYNdFMWFJSWFAnBqjEn715gbqBOnSqYLSuQYaZN7F9EjLuiA.ClmbVMj
 bGSBrzr7P8TmzLd0lhSdqHR5f_FjQ7ucU1aT16hTvTg9isXTJurSoO_OePLTQIgTHmdOQODXqLRQ
 BrD69OpUgC4MGKD2Ly0G_JFliLrSIwYOA7R1r0TGT2Gs5bqquwO32t_9E20Yv_dqg167KUurwddT
 CkR6.UKC.LFcsmMy3uWE7mOdVy.QS5P7Peq6m3qoRHrWhfqQLj.2KMiAsxO3THsnMlOSrEOLsVVQ
 WktZNvUUN0IbJJvGGZmCu3pHQQUOEgentCRcIxU1zvgyr5fzDdfHI_rpbL53D_QR7UJFae0sgi2z
 xIru8ktUPsJ7lU4Mw34f50l4ZJZOIfPzw7LFv3MOUHR9WYfyBg21aFoIFbVD5FWGQ14X9z7FeXmL
 MGbjdLc1aVjf40t62ISmDw_t_dqtH.9r7UIadegGT4q4_6KmL_n__yQnHABUCGAfTErC2ldeg8K5
 SUTjHKUbTv9Tz5m7iBW.B6Ce.Fuoex5UjNGIXi_ah_UcHj1ZxGRIxmXgIVFgVIWmetTyeig9zz1j
 HgyaZ3ROzBTOJ.gS8BCIlb5zVtddBHq6MAB62JvC_S6A3ynQwCKtpHCqCxbxVZotSea9LyKh9F7r
 eA94rIhVE9qi8tNx5d01UJ5633l6ZxPx8EMTLyPmLckWZNjDDVn3uezJFjqjC_11mkVWfKIB5ulh
 4EWxM7RlSMJ3ok1geypm4m1OnuZA.humZXjL04VB5.E.obStzHm4dHJhgUpwsyLTMVZ_ALwgYXfK
 zAHCDqJKZFKOd_vwRMeqQ2a5hPYCy6zZ.fNjpb1snT6I_.ntuyHOXwGP8GIeDabyAcYHwvBeG4Ea
 m2zqWfWvnJEdmXXi760zjtmNcA9ho6j3vur7oQisrLHdSvtfbHNGFXIg9RoTY9aqY6g.Y1J6yGOn
 BOFJiWGWo72IRlPU4DNOj4Emql9UjKdWfwMfbRxwYyauHKTOx.FLViKafj_aPmlPgStLhQ2CqOuZ
 3eicksOCQjIOdaO5ekDMaQ5cou6WJGu.2WJJLJCb.Csjx_iADoQlVMS3JMYvk9sZ_qdL_MiigbO7
 WGLE-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic316.consmr.mail.gq1.yahoo.com with HTTP; Sat, 30 Nov 2019 02:13:15 +0000
Received: by smtp426.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 705feddb06ed89f0936f2dd0cfdc3563; 
 Sat, 30 Nov 2019 02:13:13 +0000 (UTC)
Date: Sat, 30 Nov 2019 10:13:07 +0800
To: David Michael <fedora.dm0@gmail.com>
Subject: Re: Compatibility with overlayfs
Message-ID: <20191130021257.GA5562@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <CAEvUa7nxnby+rxK-KRMA46=exeOMApkDMAV08AjMkkPnTPV4CQ@mail.gmail.com>
 <20191130012900.GA2862@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191130012900.GA2862@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_181)
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Nov 30, 2019 at 09:29:04AM +0800, Gao Xiang via Linux-erofs wrote:
> Hi David,
> 
> On Fri, Nov 29, 2019 at 03:22:15PM -0500, David Michael wrote:
> > Hi,
> > 
> > I tried to test EROFS on Linux 5.4 as the root file system and mounted
> > a writable overlay (with upper layer on tmpfs) over /etc, but I get
> > ENODATA errors when attempting to modify files.  For example, adding a
> > user results in "Failed to take /etc/passwd lock: No data available".
> > Files can be modified after unlinking and restoring them so they're
> > created on the upper layer.  This is not necessary with other
> > read-only file systems (at least squashfs or ext4 with the read-only
> > feature).  I tried while forcing compact and extended inodes.
> > 
> > Is EROFS intended to be usable as a lower layer with overlayfs?
> 
> Yes, and overlayfs were used on our smartphones for development use
> only as well. I think it's weird, I will try it on the latest kernel
> now, and see if I can reproduce this issue soon...
> 
> Thanks for your report!
> 
> Thanks,
> Gao Xiang

I have reproduced this issue -- That is due to erofs will return an
unexpected -ENODATA when calling listxattr without xattr and cause
copy_up fail:

int ovl_copy_xattr(struct dentry *old, struct dentry *new)
{
	ssize_t list_size, size, value_size = 0;
	char *buf, *name, *value = NULL;
	int uninitialized_var(error);
	size_t slen;

	if (!(old->d_inode->i_opflags & IOP_XATTR) ||
	    !(new->d_inode->i_opflags & IOP_XATTR))
		return 0;

	list_size = vfs_listxattr(old, NULL, 0);  <- no xattr
	if (list_size <= 0) {
		if (list_size == -EOPNOTSUPP)
			return 0;
		return list_size;    <- will return -ENODATA
	}

since our products using xattr enabled EROFS with overlayfs,
so we didn't observe this issue before. So could you try
the following patch (If it can resolve the issue, I will
send it for 5.5-rc2 and backport to all stable version)?
Look forward to your feekback.

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index a13a78725c57..dd328c87dda7 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -649,8 +649,11 @@ ssize_t erofs_listxattr(struct dentry *dentry,
 	struct listxattr_iter it;
 
 	ret = init_inode_xattrs(d_inode(dentry));
-	if (ret)
+	if (ret) {
+		if (ret == -ENODATA)
+			return 0;
 		return ret;
+	}
 
 	it.dentry = dentry;
 	it.buffer = buffer;


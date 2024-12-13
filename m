Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1EE9F056D
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 08:25:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8gq40556z3bM7
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 18:25:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=43.155.80.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734074734;
	cv=none; b=I+7ETsJP+WI6JoL6QatF72qZx/D75f6GEez4ZLgO9sidulW5xizwXVCutnEKdgrYqN5WGRxa5jHthFc4JyYIylMR0xDdubB2iKq+fjpr5MZ61rM6lz5S7aDb8NFRkBUwkSDycqDz94fQyjQ2iisYzJ0SrXR7O0teST3I4oF1Q9z7b9exInfXviYq9UCB6viEwvhbXiPGS/vFiFKCF1MIq+NW9nT9i0PCgSqfrFHCsHa/RdM0EqYQ7eCxKG6SDN00Ge9KTt7JAlR7ogN1oOIQfTjzQuXAEnV6TUsoUUxzb9rDuoBrl8HJzMtnNGpcTDS5jxpjbq9eVGX736pCIVx/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734074734; c=relaxed/relaxed;
	bh=7kNkDxMJdSZt8C4Jj90+bEo4rMgz7OIIOxjqn9l8qgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhGOurJF1uVWcjNsvBkruhfYu1S+RmWpPxpDM0UvZAulYw4tKelw1LZxIEIVPWV+R+AZTrluGpWapdqj2D9cya5k9F3tyUIuP01e2zmJ4Ylwwymr4VNcOSRgFgNIeyQhSzgq95Zy77x3GJMix5E6jTBNkxDkDRixrikRSb5z5pdzjTQz/FXctDtpurvfgieYqHKuBhoRGUY2dkwhkR/Z4SSzeW7g+iC3/meBJmZOC5/MPAlGBD8i8RQZET6+U8U+rKEqbK1uwTlUgx5CdqMA/uTd6Ha4GnV9NSfUWHy8dWR8dFVXRKL0hAlyFL3ymaUmWfMxEF3rVOMuZMn7JfD+HA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=deepin.org; dkim=pass (1024-bit key; unprotected) header.d=deepin.org header.i=@deepin.org header.a=rsa-sha256 header.s=ukjg2408 header.b=K4KcKQTp; dkim-atps=neutral; spf=pass (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=heyuming@deepin.org; receiver=lists.ozlabs.org) smtp.mailfrom=deepin.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=deepin.org header.i=@deepin.org header.a=rsa-sha256 header.s=ukjg2408 header.b=K4KcKQTp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=deepin.org (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=heyuming@deepin.org; receiver=lists.ozlabs.org)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8gpz4cwQz30g6
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Dec 2024 18:25:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1734074697;
	bh=7kNkDxMJdSZt8C4Jj90+bEo4rMgz7OIIOxjqn9l8qgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=K4KcKQTpcPiWVQR6Y+AEFAJ8dSpoQCoF6Br0nNoQz6UAtEG0JZOblzr2FF5IBl37S
	 NViaTv6J0JvMF3WpH/vKB0ckRPOIq2mKwsPNpqR4YjrP7C2rTzrhYtqVnUfd06g/Io
	 SBgo3FGA5uDZBOGxbIKdhUjWRngiKbZnIwkE5eFY=
X-QQ-mid: bizesmtp91t1734074694tc49y1ep
X-QQ-Originating-IP: M2yOX4eSUlbd4MiC25MRYIlveejSngQmTZcuIWpgRbA=
Received: from [198.18.0.1] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Dec 2024 15:24:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3734017261353389879
Message-ID: <B2733E792B2EBCBF+0f237c6e-2465-4a35-b863-2ddc32cfbf70@deepin.org>
Date: Fri, 13 Dec 2024 15:24:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: correct erofsfuse build script
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <8725A28257A20420+20241213063250.314786-1-heyuming@deepin.org>
 <c70d771a-ad46-404c-80c0-4285e0f3ca72@linux.alibaba.com>
Content-Language: en-US
From: ComixHe <heyuming@deepin.org>
In-Reply-To: <c70d771a-ad46-404c-80c0-4285e0f3ca72@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:deepin.org:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: MIAHdi1iQo+zpI6LHt2j142ul6X913D/HEC7rnlph8OLnq0c3FptGkaT
	ASFyVNq37IAzdXuM8jkagFQJhliSN/POz0BREPSsL+h+Uw4l23WjnsiaAvGF0VXqG7KzuJF
	sLDhsYfKqtcs35TuAu5ohTi+NwcV+jCRXB040oczdLt08FquM/DZ96P0aI9rdbU0Q/agoLc
	4sUrJa7yHUCPNGOftYcKiPEGNluBzmkazIMAUglAINFUbguuoV9ouDaVKQY/suGQzhrmOuT
	AIUAc7b1T8/zOdkGpiXiMxJDQTGxYoBlT5tOq++KoqWeT0Odjb2N6LRUv8+dm8CgBFf6RN0
	Z7fYCXCeZlTg9jNjfshpK+yHn+N1AEceL3ouF5uZms1fWHGcc4WZXHNH+EA+5mcppJGnnkx
	vDX0H5EAYBP+fLs2R6uj3Aq6SnxJTgNcWdw4wIpwe5bukM+bflTybFHz/41MPGmstfbYvfH
	eTbBS3w/ZY3spbu+pSdVp1F3q9thkfiadqiJDcaDCSHs29XLEc3bR0piuMxQEMH8HYQUlCH
	We2hW86hEoTb0F4Urve3IPOZuuzDfu4T00X2FxPQ9Gc6RXenEdIt5atOpbBaEKUBoRbg9iW
	jkCVSX5owip4F13f64IvELVK98VW+C7rm7lul53LeDvmoFg7n2O7NWMed9mjWBErBNYbnAM
	0OAQdJObolISGijzr7/1axMu1ZFaAEf/IM/er0elKKT74kXhsHHPaksESg9SCUeY82yNaYO
	pZ6rHXIZE4ZaAiQdW48ru9meOZ81kp8wyxtrUhVsBb/mC7R18eMSuYMkxZ2N9CNAO1hcOAJ
	h+uP1528w3K0fvFd19WYaPiLqQC98HJcHYxjWrGHUJEWjhymi7YVWBnVBAFuPtmEX0lKY06
	q/ypLlYjI+tAURgp4yjltTM2E3IdZml9Anu4GubHiy4b5CG45H5Q5eJYPLiMKi66xhHKKp3
	s8X11BBjEAKKLQN1rXD+HghCqYR519d30dvQ=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0
X-Spam-Status: No, score=1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Level: *
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 12/13/24 14:39, Gao Xiang wrote:
> Hi Comix,
>
> On 2024/12/13 14:32, ComixHe wrote:
>> Some of the symbols required by erofsfuse are provided by liberofs.
>> When option 'enable-static-fuse' is set, all these object file should be
>> exported to liberofsfuse.a
>
> Could you give more hints why `lib_LIBRARIES` doesn't work?
Certainly.

Today, I attempted to build the latest stable version of erofs-utils and
export liberofsfuse.a.

However, when using liberofsfuse.a, the linker there reported several
errors:

(.text+0xff): undefined reference to `g_sbi'
/usr/bin/ld: (.text+0x110): undefined reference to `g_sbi'
/usr/bin/ld: (.text+0x116): undefined reference to `cfg'
/usr/bin/ld: (.text+0x12d): undefined reference to
`erofs_read_inode_from_disk'
/usr/bin/ld: (.text+0x146): undefined reference to `erofs_listxattr'
/usr/bin/ld: (.text+0x1ae): undefined reference to `erofs_listxattr'
/usr/bin/ld: (.text+0x1e5): undefined reference to `erofs_msg'
/usr/bin/ld: (.text+0x1ed): undefined reference to
`erofs_read_inode_from_disk'

I adjusted the build script according to the patch content, then rebuilt
both erofs-utils and my project.

After these fixes, everything worked as expected.
>
> I fail to get the point why `lib_LTLIBRARIES` is needed for
> static libraries...
>
> https://www.gnu.org/software/automake/manual/1.7.2/html_node/A-Library.html
>
>
> Thanks,
> Gao Xiang
>
>>
>> Signed-off-by: ComixHe <heyuming@deepin.org>
>> ---
>>   fuse/Makefile.am | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/fuse/Makefile.am b/fuse/Makefile.am
>> index 1062b73..50186da 100644
>> --- a/fuse/Makefile.am
>> +++ b/fuse/Makefile.am
>> @@ -11,9 +11,9 @@ erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la
>> ${libfuse2_LIBS} ${libfuse3_LI
>>       ${libqpl_LIBS}
>>     if ENABLE_STATIC_FUSE
>> -lib_LIBRARIES = liberofsfuse.a
>> -liberofsfuse_a_SOURCES = main.c
>> -liberofsfuse_a_CFLAGS  = -Wall -I$(top_srcdir)/include
>> -liberofsfuse_a_CFLAGS += -Dmain=erofsfuse_main ${libfuse2_CFLAGS}
>> ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
>> -liberofsfuse_a_LIBADD  = $(top_builddir)/lib/liberofs.la
>> +lib_LTLIBRARIES = liberofsfuse.la
>> +liberofsfuse_la_SOURCES = main.c
>> +liberofsfuse_la_CFLAGS  = -Wall -I$(top_srcdir)/include
>> +liberofsfuse_la_CFLAGS += -Dmain=erofsfuse_main ${libfuse2_CFLAGS}
>> ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
>> +liberofsfuse_la_LIBADD  = $(top_builddir)/lib/liberofs.la
>>   endif
>
>

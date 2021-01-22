Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF863007FB
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 16:58:02 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMkS75xPfzDr68
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Jan 2021 02:57:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531;
 helo=mail-pg1-x531.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=kx0C4dcg; dkim-atps=neutral
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DMkRv2Zy9zDqyJ
 for <linux-erofs@lists.ozlabs.org>; Sat, 23 Jan 2021 02:57:42 +1100 (AEDT)
Received: by mail-pg1-x531.google.com with SMTP id z21so3989654pgj.4
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 07:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to;
 bh=x83Ig9OK8iFjtbOGkFRLQvta1yarBpJPGNFd61nzoYU=;
 b=kx0C4dcgLx+dasU1uj0hefznj5AqHexhVZTwxVVqPKqkyngey1fKNYwjPRFDhpyYK0
 RRy7ooyyU2ytVPl3dTX2YBencnXQUdBR4hSfzob/lFg22drnK07STlzIL3GGu6f8b78C
 i2FuA/D7uMMTvdY0fnPPEMNUWgffNDYMy7g0Kwnk+DbYC6hCqnD+zW/cQNZwi5759lKh
 U8dg7dyVnYgjM+S9rtXX5PbKrk8Ew6+EG2lHP7AsOJNnLjXP00rF8JFZ+WEszSPv4vPJ
 dx98rQEL6/ngzrAWY7LAsIL/WEt42Y5fob4xgk+NaHbbuN/sDB+J0MyyhRTtt42UjBrd
 fe+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=x83Ig9OK8iFjtbOGkFRLQvta1yarBpJPGNFd61nzoYU=;
 b=kRsvCmvAPPed6Oq5EPwflfxtU1lQxfRnmJJbgXm6FC9WTTKKLJnhZ1FQOqMO1Nchfa
 WMwwNgRnJUdNRxWoE6V55B+nI/4+T3bvDkqPjgNRRIGjoFFtGGeeWDf6L9OcGICRCNyX
 b2n6zGq4QkGJbMWsiP2ekF7VrYl5zl8DVcoLBi9qOC+5FWFPh6yQtk3dxdwmQ6+d9ckR
 bFwPthzpDo3GTYfn4Ph/T7jEWvpgi7vs0DHu/4Sk/kqqybF7SzyZUeFxhb7Qb1bCaotm
 y196fp4jR/O47TorEOQcR75OphOcV/9szWSD2k3zGBLsIIc09WsaF13JAACh1elC4QyT
 PYhg==
X-Gm-Message-State: AOAM5300pP5prx0sujK1yLuSpCKO/ipvoC9Zt+ezV+67izB5hbh/0vpo
 +VL8DzE014k/LMJS/pdmu8I=
X-Google-Smtp-Source: ABdhPJwP9QA+rfsph3UMXty5mc0YGVJCmSMztSTXPVsphcU4R2Bsz3xj9uu8Fd7X6D+2xYJoKwN/0g==
X-Received: by 2002:a63:50a:: with SMTP id 10mr5138055pgf.273.1611331058447;
 Fri, 22 Jan 2021 07:57:38 -0800 (PST)
Received: from [0.0.0.0] (li1080-207.members.linode.com. [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id m10sm9565953pjn.53.2021.01.22.07.57.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Jan 2021 07:57:37 -0800 (PST)
Subject: Re: [PATCH v6 2/2] erofs-utils: optimize buffer allocation logic
To: Gao Xiang <hsiangkao@redhat.com>, Hu Weiwen <sehuww@mail.scut.edu.cn>
References: <20210116063106.5031-1-hsiangkao@aol.com>
 <20210119054951.7457-1-sehuww@mail.scut.edu.cn>
 <20210122131408.GB3105292@xiangao.remote.csb>
 <20210122132118.GC3105292@xiangao.remote.csb>
From: Huang Jianan <jnhuang95@gmail.com>
Message-ID: <c71b1475-2dc5-299c-b4ec-20d46fc71a25@gmail.com>
Date: Fri, 22 Jan 2021 23:57:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210122132118.GC3105292@xiangao.remote.csb>
Content-Type: multipart/alternative;
 boundary="------------4D09537C9D7F0F2C8970F95B"
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
Cc: guoweichao@oppo.com, linux-erofs@lists.ozlabs.org, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is a multi-part message in MIME format.
--------------4D09537C9D7F0F2C8970F95B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Weiwen, Xiang,

在 2021/1/22 21:21, Gao Xiang 写道:
> On Fri, Jan 22, 2021 at 09:14:08PM +0800, Gao Xiang wrote:
>> Hi Weiwen,
>>
>> On Tue, Jan 19, 2021 at 01:49:51PM +0800, Hu Weiwen wrote:
>>
>> ...
>>
>>>   	bb = NULL;
>>>
>>> -	list_for_each_entry(cur, &blkh.list, list) {
>>> -		unsigned int used_before, used;
>>> +	if (!used0 || alignsize == EROFS_BLKSIZ)
>>> +		goto alloc;
>>> +
>>> +	/* try to find a most-fit mapped buffer block first */
>>> +	used_before = EROFS_BLKSIZ -
>>> +		round_up(size + required_ext + inline_ext, alignsize);
>> Honestly, after seen above I feel I'm not good at math now
>> since I smell somewhat strange of this, apart from the pending
>> patch you raised [1], the algebra is
>>
>> /* since all buffers should be aligned with alignsize */
>> erofs_off_t alignedoffset = roundup(used_before, alignsize);
>>
>> and (alignedoffset + size + required_ext + inline_ext <= EROFS_BLKSIZ)
>>
>> and why it can be equal to
>> used_before = EROFS_BLKSIZ - round_up(size + required_ext + inline_ext, alignsize);
>>
>> Could you explain this in detail if possible? for example,
>> size = 3
>> inline_ext = 62
>> alignsize = 32
>>
>> so 4096 - roundup(3 + 62, 32) = 4096 - 96 = 4000
>> but, the real used_before can be even started at 4032, since
>> alignedoffset = roundup(4032, 32) = 4032
>> 4032 + 62 = 4094 <= EROFS_BLKSIZ.
>>
>> Am I stll missing something?
>>
> Oh, the example itself is wrong, yet I still feel no good at
> this formula, e.g I'm not sure if it works for alignsize which
> cannot be divided by EROFS_BLKSIZ (although currently alignsize =
> 4 or 32)
>
> Thanks,
> Gao Xiang


We can divide several parts of data in EROFS_BLKSIZ  as follows:

____________________________________________________________________________________

|||||

|  used_before |alignedoffset|   size + required_ext + inline_ext 
|tail_data |

|________________ 
|_________________|_____________________________________|___________|

Use alignsize to represent these data:

1) alignsize * num_x = used_before + alignedoffset
2) alignsize * num_y = size + required_ext + inline_ext + tail_data
3) alignsize * num_z = EROFS_BLKSIZ

So we can get,
4) num_x + num_y = num_z

If we use
used_before = EROFS_BLKSIZ - round_up(size + required_ext + inline_ext, alignsize);
here, num_y should be an integer.

Consider the following two situations:

1) If EROFS_BLKSIZ can be divisible by alignsize, num_z is an integer. so num_x is an integer.
    The following formula can be satisfied:
    erofs_off_t alignedoffset = roundup(used_before, alignsize);
    
2）If EROFS_BLKSIZ can't be divisible by alignsize, num_z isn't an integer and num_x won't be an integer.
    The formula can't be satisfied.

So I think it should be
used_before = round_down(EROFS_BLKSIZ - size-required_ext - inline_ext , alignsize);
here.

Sorry for my poor english and figure. . .


Thanks,
Jianan

>> IMO, I don't want too hard on such math, I'd like to just use
>> used_before = EROFS_BLKSIZ - (size + required_ext + inline_ext);
>> and simply skip the bb if __erofs_battach is fail (as I said before,
>> the internal __erofs_battach can be changed, and I don't want to
>> imply that always succeed.)
>>
>> If you also agree that, I'll send out a revised version along
>> with a cleanup patch to clean up erofs_balloc() as well, which
>> is more complicated than before.
>>
>> [1] https://lore.kernel.org/r/20210121162606.8168-1-sehuww@mail.scut.edu.cn/
>>
>> Thanks,
>> Gao Xiang
>>

--------------4D09537C9D7F0F2C8970F95B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Weiwen, Xiang,<br>
    </p>
    <div class="moz-cite-prefix">在 2021/1/22 21:21, Gao Xiang 写道:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20210122132118.GC3105292@xiangao.remote.csb">
      <pre class="moz-quote-pre" wrap="">On Fri, Jan 22, 2021 at 09:14:08PM +0800, Gao Xiang wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Hi Weiwen,

On Tue, Jan 19, 2021 at 01:49:51PM +0800, Hu Weiwen wrote:

...

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap=""> 	bb = NULL;

-	list_for_each_entry(cur, &amp;blkh.list, list) {
-		unsigned int used_before, used;
+	if (!used0 || alignsize == EROFS_BLKSIZ)
+		goto alloc;
+
+	/* try to find a most-fit mapped buffer block first */
+	used_before = EROFS_BLKSIZ -
+		round_up(size + required_ext + inline_ext, alignsize);
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Honestly, after seen above I feel I'm not good at math now
since I smell somewhat strange of this, apart from the pending
patch you raised [1], the algebra is

/* since all buffers should be aligned with alignsize */
erofs_off_t alignedoffset = roundup(used_before, alignsize);

and (alignedoffset + size + required_ext + inline_ext &lt;= EROFS_BLKSIZ)

and why it can be equal to
used_before = EROFS_BLKSIZ - round_up(size + required_ext + inline_ext, alignsize);

Could you explain this in detail if possible? for example,
size = 3
inline_ext = 62
alignsize = 32

so 4096 - roundup(3 + 62, 32) = 4096 - 96 = 4000
but, the real used_before can be even started at 4032, since
alignedoffset = roundup(4032, 32) = 4032
4032 + 62 = 4094 &lt;= EROFS_BLKSIZ.

Am I stll missing something?

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Oh, the example itself is wrong, yet I still feel no good at
this formula, e.g I'm not sure if it works for alignsize which
cannot be divided by EROFS_BLKSIZ (although currently alignsize =
4 or 32)

Thanks,
Gao Xiang
</pre>
    </blockquote>
    <pre class="moz-quote-pre" wrap="">

We can divide several parts of data in EROFS_BLKSIZ  as follows:
</pre>
    <p
      style="margin:0in;margin-left:.375in;font-family:微软雅黑;font-size:11.0pt"><span
        style="mso-spacerun:yes"> </span><span style="mso-spacerun:yes"> 
      </span>____________________________________________________________________________________</p>
    <p
      style="margin:0in;margin-left:.375in;font-family:微软雅黑;font-size:11.0pt"><span
        lang="zh-CN"><span style="mso-spacerun:yes"> </span> |<span
          style="mso-spacerun:yes">      </span><span
          style="mso-spacerun:yes">    </span></span><span lang="en-US"><span
          style="mso-spacerun:yes">               </span></span><span
        lang="zh-CN"><span style="mso-spacerun:yes"></span>|<span
          style="mso-spacerun:yes">                          </span></span><span
        lang="zh-CN"><span style="mso-spacerun:yes"></span>|</span><span
        lang="zh-CN"><span style="mso-spacerun:yes">                   
                                              </span></span><span
        lang="zh-CN"><span style="mso-spacerun:yes"></span>|</span><span
        lang="zh-CN"><span style="mso-spacerun:yes">                 </span></span><span
        lang="zh-CN"><span style="mso-spacerun:yes"></span>|</span></p>
    <p
      style="margin:0in;margin-left:.375in;font-family:微软雅黑;font-size:11.0pt"><span
        lang="zh-CN"><span style="mso-spacerun:yes"> </span> |<span
          style="mso-spacerun:yes">  used_before </span></span><span
        lang="en-US"><span style="mso-spacerun:yes"> </span></span><span
        lang="zh-CN"><span style="mso-spacerun:yes"> </span>|<span
          style="mso-spacerun:yes">   </span>alignedoffset</span><span
        lang="en-US"><span style="mso-spacerun:yes">  </span></span><span
        lang="zh-CN">|</span><span lang="en-US"><span
          style="mso-spacerun:yes"></span></span><span lang="zh-CN"><span
          style="mso-spacerun:yes">   size + required_ext + inline_ext 
        </span></span><span lang="en-US"><span style="mso-spacerun:yes"></span></span><span
        lang="zh-CN">|</span><span lang="en-US"><span
          style="mso-spacerun:yes"></span></span><span lang="zh-CN"><span
          style="mso-spacerun:yes">  </span>tail_data <span
          style="mso-spacerun:yes"> </span></span><span lang="en-US"><span
          style="mso-spacerun:yes"></span></span><span lang="zh-CN">|</span><span
        lang="en-US"><span style="mso-spacerun:yes"></span></span><span
        lang="zh-CN"></span></p>
    <p
      style="margin:0in;margin-left:.375in;font-family:微软雅黑;font-size:11.0pt"><span
        style="mso-spacerun:yes"> </span>
      |________________ |_________________|_____________________________________|___________|</p>
    <pre class="moz-quote-pre" wrap="">Use alignsize to represent these data:

1) alignsize * num_x = used_before + alignedoffset
2) alignsize * num_y = size + required_ext + inline_ext + tail_data
3) alignsize * num_z = EROFS_BLKSIZ

So we can get,
4) num_x + num_y = num_z

If we use
used_before = EROFS_BLKSIZ - round_up(size + required_ext + inline_ext, alignsize); 
here, num_y should be an integer.

Consider the following two situations: 
</pre>
    <pre class="moz-quote-pre" wrap="">1) If EROFS_BLKSIZ can be divisible by alignsize, num_z is an integer. so num_x is an integer.
   The following formula can be satisfied:
   erofs_off_t alignedoffset = roundup(used_before, alignsize);
   
2）If EROFS_BLKSIZ can't be divisible by alignsize, num_z isn't an integer and num_x won't be an integer.
   The formula can't be satisfied.

So I think it should be
used_before = round_down(EROFS_BLKSIZ - size-required_ext - inline_ext , alignsize);
here.

Sorry for my poor english and figure. . .


Thanks,
Jianan
</pre>
    <blockquote type="cite"
      cite="mid:20210122132118.GC3105292@xiangao.remote.csb">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">IMO, I don't want too hard on such math, I'd like to just use
used_before = EROFS_BLKSIZ - (size + required_ext + inline_ext);
and simply skip the bb if __erofs_battach is fail (as I said before,
the internal __erofs_battach can be changed, and I don't want to
imply that always succeed.)

If you also agree that, I'll send out a revised version along
with a cleanup patch to clean up erofs_balloc() as well, which
is more complicated than before.

[1] <a class="moz-txt-link-freetext" href="https://lore.kernel.org/r/20210121162606.8168-1-sehuww@mail.scut.edu.cn/">https://lore.kernel.org/r/20210121162606.8168-1-sehuww@mail.scut.edu.cn/</a>

Thanks,
Gao Xiang

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------4D09537C9D7F0F2C8970F95B--
